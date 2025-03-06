import SwiftUI
import RouterProtocol

class HomeRoute: DecodableRoute {
    var associatedTabIndex: Int?
    var dependencies: Dependencies
    var type: CombinedRouteTypeProtocol

    init(type: CombinedRouteTypeProtocol = CombinedRouteType(routes: [.push]),
         dependencies: Dependencies,
         associatedTabIndex: Int?) {
        self.type = type
        self.dependencies = dependencies
        self.associatedTabIndex = associatedTabIndex
    }

    required init(from decoder: Decoder,
                  dependencies: Dependencies,
                  associatedTabIndex: Int?) throws {
        self.type = CombinedRouteType(routes: [.push])
        self.dependencies = dependencies
        self.associatedTabIndex = associatedTabIndex
    }

    func route(from rootViewController: UIViewController,
               with navigation: RouterProtocol) -> UIViewController? {
        return HomeBuilder.createRoute(dependencies: dependencies)
    }
}
