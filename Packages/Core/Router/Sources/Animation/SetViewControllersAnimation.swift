import SwiftUI

struct SetViewControllersAnimation: @preconcurrency AnimationTypeProtocol {
    init() { }

    @MainActor func performAnimation(currentViewController: UIViewController,
                          newStack: [UIViewController],
                          navigation: UINavigationController,
                          animated: Bool) {
        navigation.setViewControllers(newStack, animated: animated)
    }
}

