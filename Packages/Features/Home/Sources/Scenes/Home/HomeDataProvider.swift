import Foundation
import NetworkProtocol
import StorageProtocol

protocol HomeDataProviderProtocol {
    func fetchBreeds(limit: Int, page: Int) async throws -> [BreedResponse]
    func fetchCatImage(id: String?) async throws -> CatImageResponse
    func fetchFavoriteBreeds() -> [BreedModel]
    func persistFavoritesBreed(_ breeds: [BreedModel])
}

final class HomeDataProvider: HomeDataProviderProtocol {
    private let network: NetworkProtocol
    private let storage: StorageManagerProtocol

    init(network: NetworkProtocol,
         storage: StorageManagerProtocol) {
        self.network = network
        self.storage = storage
    }

    func fetchBreeds(limit: Int, page: Int) async throws -> [BreedResponse] {
        let queryParams = BreedRequest.QueryParams(limit: limit, page: page)
        let request = BreedRequest(queryParams: queryParams)

        return try await network.send(request)
    }

    func fetchCatImage(id: String?) async throws -> CatImageResponse {
        let request = CatImageRequest(id: id)

        return try await network.send(request)
    }

    func fetchFavoriteBreeds() -> [BreedModel] {
        return storage.retrieve(StorageKeys.favoritesList.rawValue,
                                storageType: .coreData) ?? []
    }

    func persistFavoritesBreed(_ breeds: [BreedModel]) {
        storage.persist(breeds,
                        key: StorageKeys.favoritesList.rawValue,
                        storageType: .coreData)
    }
}
