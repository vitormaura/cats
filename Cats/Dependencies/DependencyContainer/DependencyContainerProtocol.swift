import Description
import Favourites
import Home
import NetworkProtocol
import RouterBuilder
import RouterProtocol
import StorageProtocol
import TabBar

protocol FeaturesContainerProtocol {
    var home: Home.Feature { get }
    var description: Description.Feature { get }
    var favourites: Favourites.Feature { get }
    var tabBar: TabBar.Feature { get }
}

protocol FeatureDependenciesContainerProtocol {
    var homeDependencies: Home.Dependencies { get }
    var descriptionDependencies: Description.Dependencies { get }
    var favouritesDependencies: Favourites.Dependencies { get }
    var tabBarDependencies: TabBar.Dependencies { get }
}

protocol CoreContainerProtocol {
    var router: RouterProtocol { get }
    var network: NetworkProtocol { get }
    var storage: StorageManagerProtocol { get }
}

protocol DependencyContainerProtocol: FeaturesContainerProtocol,
                                      FeatureDependenciesContainerProtocol,
                                      CoreContainerProtocol {
    var featureBuilder: FeatureBuilderProtocol? { get set }
}
