import DesignSystem
import Foundation
import Models

protocol DescriptionViewModelProtocol: ObservableObject {
    var sceneTitle: String { get }
    var imageURL: String { get }
    var origin: String { get }
    var temperament: String { get }
    var description: String { get }
    var isFavorite: Bool { get }

    func buttonAction()
}

final class DescriptionViewModel: DescriptionViewModelProtocol {
    @Published var sceneTitle: String = ""
    @Published var imageURL: String = ""
    @Published var origin: String = ""
    @Published var temperament: String = ""
    @Published var description: String = ""
    @Published var isFavorite: Bool = false

    private var content: DescriptionModel
    private var dataProvider: DescriptionDataProviderProtocol
    private var dataStore: DescriptionDataStoreProtocol

    init(content: DescriptionModel,
         dataProvider: DescriptionDataProviderProtocol,
         dataStore: DescriptionDataStoreProtocol) {
        self.content = content
        self.dataProvider = dataProvider
        self.dataStore = dataStore
        self.sceneTitle = content.breedName
        self.imageURL = content.imageURL
        self.origin = content.origin
        self.temperament = content.temperament
        self.description = content.description
        self.isFavorite = content.isFavourite
        self.dataStore.favourites = self.dataProvider.fetchFavorites()
    }

    func buttonAction() {
        content.isFavourite.toggle()
        removeOrAddFavorite(content)
    }

    private func removeOrAddFavorite(_ breed: DescriptionModel) {
        if dataStore.favourites.contains(where: { $0.id == breed.id }) {
            dataStore.favourites.removeAll(where: { $0.id == breed.id })
        } else {
            dataStore.favourites.append(breed)
        }

        dataProvider.persistFavorites(dataStore.favourites)
    }
}
