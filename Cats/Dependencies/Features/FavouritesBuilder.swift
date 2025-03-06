import Favourites

enum FavouritesBuilder {
    static func feature(_ container: DependencyContainerProtocol) -> Favourites.Feature {
        return .init(dependencies: container.favouritesDependencies)
    }

    static func dependencies(_ container: DependencyContainerProtocol) -> Favourites.Dependencies {
        return .init(router: container.router,
                     storage: container.storage)
    }
}
