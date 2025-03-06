import SwiftUI
import RouterProtocol

final class PushFromFirstVCRouteType: RouteTypeProtocol {
    func newStackPerformingRoute(currentNavigationState: NavigationState) -> NavigationState {
        currentNavigationState.viewControllers = newViewControllersAfterRoute(with: currentNavigationState)
        currentNavigationState.animationType = SetViewControllersAnimation()
        return currentNavigationState
    }

    private func newViewControllersAfterRoute(with currentNavigationState: NavigationState) -> [UIViewController] {
        var newViewControllers: [UIViewController] = currentNavigationState.viewControllers
        guard let destinationViewController = currentNavigationState.destinationViewController else {
            return newViewControllers
        }
        
        if let homeViewController = newViewControllers.first {
            newViewControllers = [homeViewController]
        }

        newViewControllers.append(destinationViewController)
        return newViewControllers
    }
}

