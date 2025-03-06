import SwiftUI

struct PresentAnimation: AnimationTypeProtocol {
    init() { }

    func performAnimation(currentViewController: UIViewController,
                          newStack: [UIViewController],
                          navigation: UINavigationController,
                          animated: Bool) {
        var newStack = newStack
        guard let viewControllerToPresent = newStack.popLast() else {
            return
        }

        navigation.setViewControllers(newStack, animated: false)
        navigation.present(viewControllerToPresent, animated: animated, completion: nil)
    }
}

