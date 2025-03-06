import DesignSystem
import Foundation
import Models

protocol FavouritesViewModelProtocol: ObservableObject {
    var sceneTitle: String { get }
    var favourites: [FavouriteModel] { get }
    var emptyImage: String { get }
    var emptyMessage: String { get }

    func onAppear()
    func buttonAction(_ favourite: FavouriteModel)
    func onTapCard(_ favourite: FavouriteModel)
}

final class FavouritesViewModel: FavouritesViewModelProtocol {
    @Published var sceneTitle: String = "Favourites"
    @Published var favourites: [FavouriteModel] = []
    @Published var emptyImage: String = ""
    @Published var emptyMessage: String = ""

    private let dataProvider: FavouritesDataProviderProtocol
    private let router: FavouritesRouterProtocol

    init(dataProvider: FavouritesDataProviderProtocol,
         router: FavouritesRouterProtocol) {
        self.dataProvider = dataProvider
        self.router = router
    }

    func onAppear() {
        favourites = dataProvider.fetchFavorites()
        emptyImage = "cat.fill"
        emptyMessage = "No favourites yet"
    }

    func buttonAction(_ favourite: FavouriteModel) {
        guard var (index, item) = favourites
            .enumerated().first(where: {
                $1.id == favourite.id
        }) else {
            return
        }

        item.isFavourite.toggle()
        favourites[index] = item
        removeOrAddFavorite(item)
    }

    private func removeOrAddFavorite(_ breed: FavouriteModel) {
        if favourites.contains(where: { $0.id == breed.id }) {
            favourites.removeAll(where: { $0.id == breed.id })
        } else {
            favourites.append(breed)
        }

        dataProvider.persistFavorites(favourites)
    }

    func onTapCard(_ favourite: FavouriteModel) {
        router.goToDescriptionRoute(content: favourite)
    }
}
