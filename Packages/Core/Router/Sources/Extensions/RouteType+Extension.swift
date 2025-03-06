import RouterProtocol

extension RouteType {
    var associatedRoute: RouteTypeProtocol {
        switch self {
        case .present:
            return PresentRouteType()
        case .push:
            return PushRouteType()
        case .pushAsFirst:
            return PushAsFirstVCRouteType()
        case .pushFromFirst:
            return PushFromFirstVCRouteType()
        case .dismiss:
            return DismissRouteType()
        case .popToIfPossible:
            return PopToIfPossibleRouteType()
        }
    }
}
