import RouterIdentifier
import RouterProtocol

extension TabBarRouteIdentifier {
    var metatype: DecodableRoute.Type {
        switch self {
        case .tabBarScreen:
            return TabBarRoute.self
        }
    }
}
