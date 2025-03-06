import SwiftUI
import RouterProtocol

final class NavigationState {
    var currentViewController: UIViewController
    var destinationViewController: UIViewController?
    var navigation: UINavigationController
    var viewControllers: [UIViewController]
    var animationType: AnimationTypeProtocol

    init(currentViewController: UIViewController,
         destinationViewController: UIViewController?,
         navigation: UINavigationController,
         viewControllers: [UIViewController],
         animationType: AnimationTypeProtocol) {
        self.currentViewController = currentViewController
        self.destinationViewController = destinationViewController
        self.navigation = navigation
        self.viewControllers = viewControllers
        self.animationType = animationType
    }
}

