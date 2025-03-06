import Description
import Favourites
import Home
import TabBar

extension DependencyContainer: FeatureDependenciesContainerProtocol {
    var homeDependencies: Home.Dependencies {
        homeDependenciesBuilder(self)
    }

    var descriptionDependencies: Description.Dependencies {
        descriptionDependenciesBuilder(self)
    }

    var favouritesDependencies: Favourites.Dependencies {
        favouritesDependenciesBuilder(self)
    }

    var tabBarDependencies: TabBar.Dependencies {
        tabBarDependenciesBuilder(self)
    }
}
