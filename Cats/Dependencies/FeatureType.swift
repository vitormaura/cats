import Description
import Favourites
import Home
import RouterBuilder
import TabBar

enum FeatureType: FeatureTypeProtocol, CaseIterable {
    case home
    case description
    case favourites
    case tabBar

    var configuration: FeatureConfiguration {
        guard let configuration = FeatureType.configurations[self] else {
            return .init(metatype: Home.Feature.self)
        }
    
        return configuration
    }

    private static var configurations: [FeatureType: FeatureConfiguration] = {
        return [
            .home: FeatureConfiguration(metatype: Home.Feature.self),
            .description: FeatureConfiguration(metatype: Description.Feature.self),
            .favourites: FeatureConfiguration(metatype: Favourites.Feature.self),
            .tabBar: FeatureConfiguration(metatype: TabBar.Feature.self),
        ]
    }()

    mutating func updateConfiguration(for type: FeatureType, with configuration: FeatureConfiguration) {
         FeatureType.configurations[type] = configuration
     }
}
