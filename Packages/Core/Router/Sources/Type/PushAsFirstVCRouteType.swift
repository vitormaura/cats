import Foundation
import RouterProtocol

final class PushAsFirstVCRouteType: RouteTypeProtocol {
    func newStackPerformingRoute(currentNavigationState: NavigationState) -> NavigationState {
        guard let destinationViewController = currentNavigationState.destinationViewController else {
            return currentNavigationState
        }

        currentNavigationState.viewControllers = [destinationViewController]
        currentNavigationState.animationType = SetViewControllersAnimation()
        return currentNavigationState
    }
}
