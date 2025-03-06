import Foundation
import Router
import Network
import Storage

enum CoreBuilder {
    static func router(_ container: DependencyContainerProtocol) -> Router {
        Router()
    }

    static func network(_ container: DependencyContainerProtocol) -> Network {
        let defaultHeaders: [String: String] = ["x-api-key": "live_ai4aYGUvVIBF3DPlXAV5GKQOu7w0BEIzoWYYFz6RibTQWuno9mTwjGhP2rNhrjAZ"]
        let baseURL = URL(string: "https://api.thecatapi.com/")!
        let requestInfo = RequestInfo(baseURL: baseURL, defaultHeaders: defaultHeaders)
        return NetworkBuilder.create(requestInfo: requestInfo)
    }

    static func storage(_ container: DependencyContainerProtocol) -> StorageManager {
        let persistentContainer = PersistentContainer()
        let coreDataManager = CoreDataManager(persistentContainer: persistentContainer)
        let storageFactory = StorageFactory(coreDataManager: coreDataManager)
        return StorageManager(storageFactory: storageFactory)
    }
}
