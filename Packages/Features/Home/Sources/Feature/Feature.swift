import FeatureProtocol
import RouterIdentifier
import RouterProtocol

public final class Feature: FeatureProtocol {
    private let dependencies: Dependencies
    
    public init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    public static func isEnabled(withIdentifier id: String) -> Bool {
        return HomeRouteIdentifier(rawValue: id) != nil
    }

    public func initialRoute(associatedTabIndex: Int?) -> Route? {
        return HomeRoute(dependencies: dependencies, associatedTabIndex: associatedTabIndex)
    }

    public func route(from decoder: Decoder, with identifier: String, associatedTabIndex: Int?) throws -> Route? {
        guard let identifier = HomeRouteIdentifier(rawValue: identifier) else {
            return nil
        }

        return try identifier.metatype.init(from: decoder,
                                            dependencies: dependencies,
                                            associatedTabIndex: associatedTabIndex)
    }
}
