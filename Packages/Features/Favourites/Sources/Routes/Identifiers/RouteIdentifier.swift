import RouterIdentifier

extension FavouritesRouteIdentifier {
    var metatype: DecodableRoute.Type {
        switch self {
        case .favouritesScreen:
            return FavouritesRoute.self
        }
    }
}
