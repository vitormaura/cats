import Foundation
import StorageProtocol

protocol DescriptionDataProviderProtocol {
    func fetchFavorites() -> [DescriptionModel]
    func persistFavorites(_ favourites: [DescriptionModel])
}

final class DescriptionDataProvider: DescriptionDataProviderProtocol {
    private let storage: StorageManagerProtocol

    init(storage: StorageManagerProtocol) {
        self.storage = storage
    }

    func fetchFavorites() -> [DescriptionModel] {
        return storage.retrieve(StorageKeys.favoritesList.rawValue,
                                storageType: .coreData) ?? []
    }

    func persistFavorites(_ favourites: [DescriptionModel]) {
        storage.persist(favourites,
                        key: StorageKeys.favoritesList.rawValue,
                        storageType: .coreData)
    }
}
