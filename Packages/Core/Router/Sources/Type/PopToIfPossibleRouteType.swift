import SwiftUI
import RouterProtocol

final class PopToIfPossibleRouteType: RouteTypeProtocol {
    func newStackPerformingRoute(currentNavigationState: NavigationState) -> NavigationState {
        guard let destinationViewController = currentNavigationState.destinationViewController else {
            return currentNavigationState
        }

        let updatedNavigationState = self.updateStackToPerformPop(
            destinationViewController: destinationViewController,
            currentNavigationState: currentNavigationState
        )

        guard let navigationState = updatedNavigationState else {
            return push(destinationViewController: destinationViewController,
                        currentNavigationState: currentNavigationState)
        }

        return popTo(viewController: destinationViewController,
                     currentNavigationState: navigationState)
    }

    private func updateStackToPerformPop(destinationViewController: UIViewController,
                                         currentNavigationState: NavigationState) -> NavigationState? {
        let destinationViewControllerType = type(of: destinationViewController)
        if currentNavigationState.containsViewController(of: destinationViewControllerType) {
            return currentNavigationState
        } else if let navigationBeforeTabBar = currentNavigationState.navigation.tabBarController?.navigationController,
            navigationBeforeTabBar.containsViewController(of: destinationViewControllerType),
            let currentViewController = navigationBeforeTabBar.viewControllers.last
        {
            currentNavigationState.navigation = navigationBeforeTabBar
            currentNavigationState.viewControllers = navigationBeforeTabBar.viewControllers
            currentNavigationState.currentViewController = currentViewController
            return currentNavigationState
        }
        return nil
    }

    private func push(destinationViewController: UIViewController,
                      currentNavigationState: NavigationState) -> NavigationState {
        currentNavigationState.viewControllers.append(destinationViewController)
        currentNavigationState.animationType = SetViewControllersAnimation()
        return currentNavigationState
    }

    private func popTo(viewController: UIViewController,
                       currentNavigationState: NavigationState) -> NavigationState {
        var newStack = currentNavigationState.newStack(viewControllerType: type(of: viewController))
        newStack = stackReplacingLastViewController(of: newStack, by: viewController)
        currentNavigationState.viewControllers = newStack
        currentNavigationState.animationType = PopAnimation()
        return currentNavigationState
    }

    private func stackReplacingLastViewController(of stack: [UIViewController],
                                                  by viewController: UIViewController) -> [UIViewController] {
        var newStack = stack
        _ = newStack.popLast()
        newStack.append(viewController)
        return newStack
    }
}
