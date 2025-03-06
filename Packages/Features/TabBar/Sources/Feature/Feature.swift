import RouterBuilder
import FeatureProtocol
import RouterIdentifier
import RouterProtocol

public final class Feature: FeatureProtocol {
    private let dependencies: Dependencies
    private weak var featureBuilder: FeatureBuilderProtocol?
    private let featureTypes: [FeatureTypeProtocol]

    public init(dependencies: Dependencies,
                featureBuilder: FeatureBuilderProtocol?,
                featureTypes: [FeatureTypeProtocol]) {
        self.dependencies = dependencies
        self.featureBuilder = featureBuilder
        self.featureTypes = featureTypes
    }

    public static func isEnabled(withIdentifier id: String) -> Bool {
        return TabBarRouteIdentifier(rawValue: id) != nil
    }

    public func initialRoute(associatedTabIndex: Int?) -> Route? {
        return TabBarRoute(associatedTabIndex: associatedTabIndex,
                           dependencies: dependencies,
                           featureBuilder: featureBuilder,
                           featureTypes: featureTypes)
    }

    public func route(from decoder: Decoder, with identifier: String, associatedTabIndex: Int?) throws -> Route? {
        guard let identifier = TabBarRouteIdentifier(rawValue: identifier) else {
            return nil
        }

        return try identifier.metatype.init(from: decoder,
                                            featureBuilder: featureBuilder,
                                            dependencies: dependencies,
                                            featureTypes: featureTypes)
    }
}
