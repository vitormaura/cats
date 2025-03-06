import RouterProtocol
import StorageProtocol

public final class Dependencies {
    let router: RouterProtocol
    let storage: StorageManagerProtocol

    public init(router: RouterProtocol,
                storage: StorageManagerProtocol) {
        self.router = router
        self.storage = storage
    }
}
