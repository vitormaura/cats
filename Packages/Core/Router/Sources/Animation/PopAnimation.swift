import SwiftUI

struct PopAnimation: AnimationTypeProtocol {
    init() { }

    func performAnimation(currentViewController: UIViewController,
                          newStack: [UIViewController],
                          navigation: UINavigationController,
                          animated: Bool) {
        guard currentViewController.navigationController === navigation else {
            navigation.setViewControllers(newStack, animated: animated)
            return
        }

        let stackWithCurrentVC = newStack + [currentViewController]
        navigation.setViewControllers(stackWithCurrentVC, animated: false)
        navigation.popViewController(animated: animated)
    }
}

