import SwiftUI

public protocol CombinedRouteTypeProtocol {
    var routes: [RouteType] { get set }
}

public final class CombinedRouteType: CombinedRouteTypeProtocol {
    public typealias Completion = (_ currentViewController: UIViewController) -> Void

    public var routes: [RouteType]
    public var completion: Completion?

    public init(routes: [RouteType], completion: Completion? = nil) {
        self.routes = routes
        self.completion = completion
    }

    public func combinedRouteType() -> CombinedRouteType {
        return self
    }
}
