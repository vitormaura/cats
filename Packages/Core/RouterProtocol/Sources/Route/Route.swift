import SwiftUI

public protocol Route {
    var associatedTabIndex: Int? { get set }
    var type: CombinedRouteTypeProtocol { get set }

    func route(from rootViewController: UIViewController,
               with navigation: RouterProtocol) -> UIViewController?
}
