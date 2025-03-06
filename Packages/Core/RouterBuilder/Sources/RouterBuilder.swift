import FeatureProtocol
import RouterProtocol

public final class RouterBuilder: RouterBuilderProtocol {
    private let featureBuilder: FeatureBuilderProtocol
    private let features: [FeatureTypeProtocol]

    public init(featureBuilder: FeatureBuilderProtocol,
                features: [FeatureTypeProtocol]) {
        self.featureBuilder = featureBuilder
        self.features = features
    }

    public func route(from decoder: Decoder, with identifier: String) -> Route? {
        guard let featureAndTab = featureAndAssociatedTab(forIdentifier: identifier),
              let route = try? featureAndTab.feature.route(from: decoder,
                                                           with: identifier,
                                                           associatedTabIndex: featureAndTab.associatedTabIndex) else {
            print("Route not found for identifier: \(identifier)")
            return nil
        }

        return route
    }

    private func featureAndAssociatedTab(forIdentifier identifier: String) -> (feature: FeatureProtocol, associatedTabIndex: Int?)? {
        guard let featureType: FeatureTypeProtocol = getFeatureType(forRouteIdentifier: identifier),
              let feature = featureBuilder.feature(type: featureType) else {
            return nil
        }

        return (feature, featureType.configuration.associatedTab)
    }

    private func getFeatureType(forRouteIdentifier identifier: String) -> FeatureTypeProtocol? {
        return features.first {
            $0.configuration.metatype.isEnabled(withIdentifier: identifier)
        }
    }
}
