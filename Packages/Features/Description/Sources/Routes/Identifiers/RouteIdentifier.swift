import RouterIdentifier

extension DescriptionRouteIdentifier {
    var metatype: DecodableRoute.Type {
        switch self {
        case .descriptionScreen:
            return DescriptionRoute.self
        }
    }
}
