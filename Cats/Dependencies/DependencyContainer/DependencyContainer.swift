import RouterBuilder

final class DependencyContainer: DependencyContainerProtocol {
    @LazyInjection var networkBuilder = CoreBuilder.network
    @LazyInjection var routerBuilder = CoreBuilder.router
    @LazyInjection var storageBuilder = CoreBuilder.storage

    @LazyInjection var homeBuilder = HomeBuilder.feature
    @LazyInjection var homeDependenciesBuilder = HomeBuilder.dependencies

    @LazyInjection var descriptionBuilder = DescriptionBuilder.feature
    @LazyInjection var descriptionDependenciesBuilder = DescriptionBuilder.dependencies

    @LazyInjection var favouritesBuilder = FavouritesBuilder.feature
    @LazyInjection var favouritesDependenciesBuilder = FavouritesBuilder.dependencies

    @LazyInjection var tabBarBuilder = TabBarBuilder.feature
    @LazyInjection var tabBarDependenciesBuilder = TabBarBuilder.dependencies

    weak var featureBuilder: FeatureBuilderProtocol?

    init() { }
}
