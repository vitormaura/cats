import Foundation
import RouterProtocol

final class PushRouteType: RouteTypeProtocol {
    func newStackPerformingRoute(currentNavigationState: NavigationState) -> NavigationState {
        guard let destinationViewController = currentNavigationState.destinationViewController else {
            return currentNavigationState
        }

        if let lastViewController = currentNavigationState.viewControllers.last,
           lastViewController === destinationViewController {
            return currentNavigationState
        }

        currentNavigationState.viewControllers.append(destinationViewController)
        currentNavigationState.animationType = SetViewControllersAnimation()
        return currentNavigationState
    }
}

