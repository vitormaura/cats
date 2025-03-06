import Foundation
import RouterProtocol

final class DismissRouteType: RouteTypeProtocol {
    func newStackPerformingRoute(currentNavigationState: NavigationState) -> NavigationState {
        var newStack = currentNavigationState.viewControllers
        newStack.removeLast()

        let updatedNavigationState = NavigationState(currentViewController: currentNavigationState.currentViewController,
                                                      destinationViewController: currentNavigationState.destinationViewController,
                                                      navigation: currentNavigationState.navigation,
                                                      viewControllers: newStack,
                                                      animationType: PopAnimation())
        
        return updatedNavigationState
    }
}
