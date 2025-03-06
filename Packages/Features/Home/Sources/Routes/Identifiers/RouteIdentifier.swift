import RouterIdentifier

extension HomeRouteIdentifier {
    var metatype: DecodableRoute.Type {
        switch self {
        case .homeScreen:
            return HomeRoute.self
        }
    }
}
