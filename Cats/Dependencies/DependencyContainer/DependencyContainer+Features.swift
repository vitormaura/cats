import Description
import Favourites
import Home
import TabBar

extension DependencyContainer: FeaturesContainerProtocol {
    var home: Home.Feature {
        homeBuilder(self)
    }

    var description: Description.Feature {
        descriptionBuilder(self)
    }

    var favourites: Favourites.Feature {
        favouritesBuilder(self)
    }

    var tabBar: TabBar.Feature {
        tabBarBuilder(self)
    }
}
