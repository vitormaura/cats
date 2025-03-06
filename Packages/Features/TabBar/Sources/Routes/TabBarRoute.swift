import RouterBuilder
import RouterProtocol
import SwiftUI

public class TabBarRoute: DecodableRoute {
    public var associatedTabIndex: Int?
    public var type: CombinedRouteTypeProtocol
    private let dependencies: Dependencies

    private weak var featureBuilder: FeatureBuilderProtocol?
    private let featureTypes: [FeatureTypeProtocol]
    private let content: TabBarContent?

    private enum CodingKeys: String, CodingKey {
        case content
    }

    public required init(from decoder: Decoder,
                         featureBuilder: FeatureBuilderProtocol?,
                         dependencies: Dependencies,
                         featureTypes: [FeatureTypeProtocol]) throws {
        self.dependencies = dependencies
        self.featureBuilder = featureBuilder
        self.type = CombinedRouteType(routes: [.pushAsFirst])
        self.featureTypes = featureTypes
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.content = try container.decodeIfPresent(TabBarContent.self, forKey: .content)
    }

    public required init(associatedTabIndex: Int?,
                         dependencies: Dependencies,
                         featureBuilder: FeatureBuilderProtocol?,
                         featureTypes: [FeatureTypeProtocol]) {
        self.dependencies = dependencies
        self.featureBuilder = featureBuilder
        self.type = CombinedRouteType(routes: [.pushAsFirst])
        self.featureTypes = featureTypes
        self.content = nil
    }

    public func route(from rootViewController: UIViewController,
                      with navigation: RouterProtocol) -> UIViewController? {
        return TabBarBuilder.createRoute(dependencies: dependencies, tabs: tabs())
    }

    private func tabs() -> [Tab] {
        featureBuilder?.resetAllTabIndexes()
        var tabs = content?.tabs ?? TabModel.allCases.map({ $0.tab })
        tabs.enumerated().forEach({ index, appTab in
            guard appTab.isEnabled,
                  let identifier = appTab.route.identifier,
                  let type = featureType(forRouteIdentifier: identifier) else {
                return
            }

            self.associateTabIndex(for: type, associatedTab: index)
            tabs[index].route.route?.associatedTabIndex = index
        })

        return tabs
    }

    private func featureType(forRouteIdentifier identifier: String) -> FeatureTypeProtocol? {
        return featureTypes.first {
            $0.configuration.metatype.isEnabled(withIdentifier: identifier)
        }
    }

    private func associateTabIndex(for feature: FeatureTypeProtocol, associatedTab: Int) {
        guard var featureModule = featureBuilder?.feature(type: feature) else {
            return
        }

        let config = FeatureConfiguration(metatype: feature.configuration.metatype, associatedTab: associatedTab)
        featureBuilder?.associateTabIndex(type: feature, config: config)
    }
}
