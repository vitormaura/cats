import Home

enum HomeBuilder {
    static func feature(_ container: DependencyContainerProtocol) -> Home.Feature {
        return .init(dependencies: container.homeDependencies)
    }

    static func dependencies(_ container: DependencyContainerProtocol) -> Home.Dependencies {
        return .init(network: container.network,
                     router: container.router,
                     storage: container.storage)
    }
}
