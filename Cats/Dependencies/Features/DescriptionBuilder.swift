import Description

enum DescriptionBuilder {
    static func feature(_ container: DependencyContainerProtocol) -> Description.Feature {
        return .init(dependencies: container.descriptionDependencies)
    }

    static func dependencies(_ container: DependencyContainerProtocol) -> Description.Dependencies {
        return .init(router: container.router,
                     storage: container.storage)
    }
}
