import TabBar

enum TabBarBuilder {
    static func feature(_ container: DependencyContainerProtocol) -> TabBar.Feature {
        return .init(dependencies: container.tabBarDependencies,
                     featureBuilder: container.featureBuilder,
                     featureTypes: FeatureType.allCases)
    }

    static func dependencies(_ container: DependencyContainerProtocol) -> TabBar.Dependencies {
        return .init(router: container.router)
    }
}
