import SwiftUI

protocol AnimationTypeProtocol {
    func performAnimation(currentViewController: UIViewController,
                          newStack: [UIViewController],
                          navigation: UINavigationController,
                          animated: Bool)
}
