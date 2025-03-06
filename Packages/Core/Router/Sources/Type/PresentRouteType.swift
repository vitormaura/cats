import Foundation
import RouterProtocol

final class PresentRouteType: RouteTypeProtocol {
    func newStackPerformingRoute(currentNavigationState: NavigationState) -> NavigationState {
        guard let destinationViewController = currentNavigationState.destinationViewController else {
            return currentNavigationState
        }

        currentNavigationState.viewControllers.append(destinationViewController)
        currentNavigationState.animationType = PresentAnimation()
        return currentNavigationState
    }
}
