import Foundation
import StorageProtocol

protocol FavouritesDataProviderProtocol {
    func fetchFavorites() -> [FavouriteModel]
    func persistFavorites(_ favourites: [FavouriteModel])
}

final class FavouritesDataProvider: FavouritesDataProviderProtocol {
    private let storage: StorageManagerProtocol

    init(storage: StorageManagerProtocol) {
        self.storage = storage
    }

    func fetchFavorites() -> [FavouriteModel] {
        return storage.retrieve(StorageKeys.favoritesList.rawValue,
                                storageType: .coreData) ?? []
    }

    func persistFavorites(_ favourites: [FavouriteModel]) {
        storage.persist(favourites,
                        key: StorageKeys.favoritesList.rawValue,
                        storageType: .coreData)
    }
}
