import NetworkProtocol
import RouterProtocol
import StorageProtocol

public final class Dependencies {
    let network: NetworkProtocol
    let router: RouterProtocol
    let storage: StorageManagerProtocol

    public init(network: NetworkProtocol,
                router: RouterProtocol,
                storage: StorageManagerProtocol) {
        self.network = network
        self.router = router
        self.storage = storage
    }
}
