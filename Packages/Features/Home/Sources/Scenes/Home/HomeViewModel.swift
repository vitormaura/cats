import DesignSystem
import Foundation
import Models

protocol HomeViewModelProtocol: ObservableObject {
    var viewState: ViewState { get }
    var sceneTitle: String { get }
    var widgets: [any WidgetModel] { get }

    func onAppear()
    func tryAgain()
    func onAppearWidget<Widget: WidgetModel>(_ widget: Widget)
    func onTapWidget<Widget: WidgetModel>(_ widget: Widget)
}

final class HomeViewModel: HomeViewModelProtocol {
    @Published var viewState: ViewState = .loading
    @Published var sceneTitle: String = "Cats"
    @Published var widgets: [any WidgetModel] = []
    @Published var isFavorite: Bool = false

    private var dataStore: HomeDataStoreProtocol
    private let dataProvider: HomeDataProviderProtocol
    private let router: HomeRouterProtocol

    init(dataStore: HomeDataStoreProtocol,
         dataProvider: HomeDataProviderProtocol,
         router: HomeRouterProtocol) {
        self.dataStore = dataStore
        self.dataProvider = dataProvider
        self.router = router
    }

    func onAppear() {
        viewState = .loading
        widgets.removeAll()
        dataStore.resetValues()
        setFavorites()
        Task.init { @MainActor in
            do {
                setupSearchWidget()
                try await fetchHomeData()
                self.viewState = .success
            } catch {
                self.viewState = .error()
            }
        }
    }

    private func setFavorites() {
        dataStore.favoriteBreeds = self.dataProvider.fetchFavoriteBreeds()
    }

    private func setupSearchWidget() {
        let searchWidget = SearchWidgetModel(delegate: self)
        widgets.append(searchWidget)
    }

    private func fecthMorePages() {
        addLoadingWidget()
        dataStore.currentPage += 1

        Task.init { @MainActor in
            removeErrorWidget()
            do {
                try await fetchHomeData()
            } catch {
                addErrorWidget()
            }
            removeLoadingWidget()
            dataStore.widgetsNoFilter = widgets
        }
    }

    private func addLoadingWidget() {
        let loadingWidget = LoadingWidgetModel()
        self.widgets.append(loadingWidget)
    }

    private func removeErrorWidget() {
        self.widgets.removeAll {
            $0 is ErrorWidgetModel
        }
    }

    private func addErrorWidget() {
        let errorWidget = ErrorWidgetModel()
        self.widgets.append(errorWidget)
    }

    private func removeLoadingWidget() {
        self.widgets.removeAll {
            $0 is LoadingWidgetModel
        }
    }

    @MainActor
    private func fetchHomeData() async throws {
        let breedData = try await dataProvider.fetchBreeds(limit: dataStore.limit,
                                                           page: dataStore.currentPage)
        self.widgets += [try await buildGridWidget(breedData)]
        dataStore.widgetsNoFilter = widgets
    }

    @MainActor
    private func buildGridWidget(_ breedData: [BreedResponse]) async throws -> any WidgetModel {
        return GridWidgetModel(widgets: await try breedData.concurrentMap { breed in
            let image = try await self.dataProvider.fetchCatImage(id: breed.referenceImageID)
            let isFavourite = self.dataStore.favoriteBreeds.contains(where: { $0.id == breed.id }) ?? false
            let widget = CatWidgetModel(id: breed.id,
                                        imageURL: image.url,
                                        name: breed.name,
                                        isFavorite: isFavourite,
                                        delegate: self)
            self.dataStore.lastLoadedWidget = widget
            self.dataStore.breedData.append(.init(id: breed.id,
                                                  imageURL: image.url,
                                                  breedName: breed.name,
                                                  origin: breed.origin,
                                                  temperament: breed.temperament,
                                                  description: breed.description,
                                                  isFavourite: isFavourite))
            return widget
        }, delegate: self)
    }

    func tryAgain() {
        Task.init { @MainActor in
            widgets.removeAll()
            await self.onAppear()
        }
    }
}

extension HomeViewModel: CatWidgetViewDelegate {
    func buttonAction(widget: CatWidgetModel) {
        guard var (index, breed) = dataStore
            .breedData.enumerated().first(where: {
            $1.id == widget.id
        }) else {
            return
        }

        breed.isFavourite.toggle()
        dataStore.breedData[index] = breed
        removeOrAddFavorite(breed)
    }

    private func removeOrAddFavorite(_ breed: BreedModel) {
        if dataStore.favoriteBreeds.contains(where: { $0.id == breed.id }) {
            dataStore.favoriteBreeds.removeAll(where: { $0.id == breed.id })
        } else {
            dataStore.favoriteBreeds.append(breed)
        }

        dataProvider.persistFavoritesBreed(dataStore.favoriteBreeds)
    }
}

extension HomeViewModel: GridWidgetViewDelegate {
    func onAppearWidget<Widget: WidgetModel>(_ widget: Widget) {
        (widget as? WidgetHasPresentableVisitor)?.onAppear(using: self)
    }

    func onTapWidget<Widget: WidgetModel>(_ widget: Widget) {
        (widget as? WidgetHasTappableVisitor)?.onTap(from: self)
    }
}

extension HomeViewModel: SearchWidgetViewDelegate {
    func onChange(_ text: String) {
        dataStore.isSearching = text.isEmpty == false
        if dataStore.isSearching {
            var widgetsToSearch = dataStore.widgetsNoFilter.compactMap {
                ($0 as? WidgetHasSearchableVisitor)?.searchBy(text: text, on: self)
            }
            removeAllIfNeeded()
            setFilterOrEmptyState(widgetsToSearch)
        } else {
            widgets = dataStore.widgetsNoFilter
        }
    }

    private func removeAllIfNeeded() {
        widgets.removeAll(where: {
            $0 is WidgetHasSearchableVisitor ||
            $0 is LoadingWidgetModel ||
            $0 is ErrorWidgetModel ||
            $0 is EmptyWidgetModel
        })
    }

    private func setFilterOrEmptyState(_ widgetsToSearch: [any WidgetModel]) {
        let filteredOrEmpyList = widgetsToSearch.isEmpty ? [EmptyWidgetModel()] : widgetsToSearch
        widgets.append(contentsOf: filteredOrEmpyList)
    }
}

extension HomeViewModel: HomeSearchableVisitor {
    func searchBy(text: String, on widget: GridWidgetModel) -> (any WidgetModel)? {
        var newWidget = widget
        newWidget.widgets = widget.widgets.compactMap {
            ($0 as? WidgetHasSearchableVisitor)?.searchBy(text: text, on: self)
        }
        return newWidget.widgets.isEmpty ? nil : newWidget
    }
    
    func searchBy(text: String, on widget: CatWidgetModel) -> (any WidgetModel)? {
        widget.name.lowercased().contains(text.lowercased()) ? widget : nil
    }
}

extension HomeViewModel: HomePresentableVisitor {
    func onApper(with widget: CatWidgetModel) {
        guard widget.id == dataStore.lastLoadedWidget?.id,
              shouldLoadMore() else {
            return
        }

        fecthMorePages()
    }

    private func shouldLoadMore() -> Bool {
        dataStore.isSearching == false &&
        dataStore.currentPage <= dataStore.totalPages &&
        widgets.filter({
            $0 is LoadingWidgetModel || $0 is ErrorWidgetModel
        }).isEmpty
    }
}

extension HomeViewModel: HomeTappableVisitor {
    func onTap(from widget: CatWidgetModel) {
        guard let breed = dataStore.breedData.first(where: {
            $0.id == widget.id
        }) else {
            return
        }

        router.goToDescriptionRoute(content: breed)
    }

    func onTap(from widget: ErrorWidgetModel) {
        fecthMorePages()
    }
}
