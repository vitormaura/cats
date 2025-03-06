import SwiftUI
import RouterProtocol

protocol PerformRouteTypeProtocol: CombinedRouteTypeProtocol {
    func performRoute(from currentViewController: UIViewController,
                      to destinationViewController: UIViewController?,
                      in navigation: UINavigationController,
                      animated: Bool)
}

extension CombinedRouteType: @preconcurrency PerformRouteTypeProtocol {
    @MainActor func performRoute(from currentViewController: UIViewController,
                      to destinationViewController: UIViewController?,
                      in navigation: UINavigationController,
                      animated: Bool) {
        
        guard isValidCurrentViewController(currentViewController, in: navigation) else {
            return
        }

        let currentNavigationState = NavigationState(currentViewController: currentViewController,
                                                     destinationViewController: destinationViewController,
                                                     navigation: navigation,
                                                     viewControllers: navigation.viewControllers,
                                                     animationType: SetViewControllersAnimation())

        perform(routes: routes,
                currentNavigationState: currentNavigationState,
                animated: animated)

        performCompletion(newStack: currentNavigationState.viewControllers)
    }

    @MainActor private func isValidCurrentViewController(_ currentViewController: UIViewController,
                                              in navigation: UINavigationController) -> Bool {
        if navigation.viewControllers.contains(currentViewController) {
            return navigation.viewControllers.last === currentViewController
        } else {
            return currentViewController is UINavigationController
        }
    }

    private func perform(routes: [RouteType],
                         currentNavigationState: NavigationState,
                         animated: Bool) {
        guard routes.isEmpty == false else {
            return
        }

        var currentNavigationState = currentNavigationState
        routes.forEach {
            currentNavigationState = performRoute($0, currentNavigationState: currentNavigationState)
        }

        performAnimation(currentNavigationState: currentNavigationState,
                         animated: animated)
    }

    private func performRoute(_ routeType: RouteType,
                              currentNavigationState: NavigationState) -> NavigationState {
        let route = routeType.associatedRoute
        return route.newStackPerformingRoute(currentNavigationState: currentNavigationState)
    }

    private func performAnimation(currentNavigationState: NavigationState,
                                  animated: Bool) {
        let animationType = currentNavigationState.animationType
        let currentViewController = currentNavigationState.currentViewController
        animationType.performAnimation(currentViewController: currentViewController,
                                       newStack: currentNavigationState.viewControllers,
                                       navigation: currentNavigationState.navigation,
                                       animated: animated)
    }

    private func performCompletion(newStack: [UIViewController]) {
        guard let currentViewController = newStack.last else {
            return
        }
        completion?(currentViewController)
    }
}
