import NetworkProtocol
import RouterProtocol
import StorageProtocol

extension DependencyContainer: CoreContainerProtocol {
    var router: RouterProtocol {
        routerBuilder(self)
    }

    var network: NetworkProtocol {
        networkBuilder(self)
    }

    var storage: StorageManagerProtocol {
        storageBuilder(self)
    }
}
