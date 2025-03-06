import SwiftUI
import RouterProtocol

public class Router: RouterProtocol {
    public init() { }

    public func handle(_ route: Route?,
                       animated: Bool,
                       rootViewController: UIViewController) {
        guard let route = route else {
            print("Router: Route is nil")
            return
        }
        
        guard let navigationController = rootViewController.navigationController ??
              (rootViewController as? UINavigationController) else {
            print("Router: Root view controller does not have a navigation controller")
            return
        }

        var currentNavigationController = navigationController
        var isChangingTab = false
        if let tabBarController = rootViewController.tabBarController,
           let associatedTabIndex = route.associatedTabIndex,
           associatedTabIndex < tabBarController.viewControllers?.count ?? 0,
           associatedTabIndex != tabBarController.selectedIndex,
           let navigationController = tabBarController.viewControllers?[associatedTabIndex] as? UINavigationController {
            currentNavigationController.popToRootViewController(animated: false)
            tabBarController.selectedIndex = associatedTabIndex
            currentNavigationController = navigationController
            isChangingTab = true
        }

        perform(route: route,
                from: rootViewController,
                on: navigationController,
                animated: animated)
    }

    private func perform(route: Route,
                         from rootViewController: UIViewController,
                         on navigationController: UINavigationController,
                         animated: Bool) {
        guard let viewController = route.route(from: rootViewController, with: self) else {
            print("Router: Failed to route to view controller")
            return
        }

        if let combinedRouteType = route.type as? PerformRouteTypeProtocol {
            combinedRouteType.performRoute(from: rootViewController,
                                           to: viewController,
                                           in: navigationController,
                                           animated: animated)
        } else {
            print("Router: Route type is not a CombinedRouteTypeProtocol")
        }
    }
}
