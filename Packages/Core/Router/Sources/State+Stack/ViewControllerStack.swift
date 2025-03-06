import SwiftUI

protocol ViewControllerStack {
    var viewControllers: [UIViewController] { get }
    var navigation: UINavigationController { get }
}

extension ViewControllerStack {
    func firstViewController<T: UIViewController>(of type: T.Type) -> UIViewController? {
        return viewControllers.first(where: { $0.isKind(of: type) })
    }

    func firstViewControllerIndex<T: UIViewController>(of type: T.Type) -> Int? {
        return viewControllers.firstIndex(where: { $0.isKind(of: type) })
    }

    func containsViewController<T: UIViewController>(of type: T.Type) -> Bool {
        return firstViewController(of: type) != nil
    }

    func lastViewController<T: UIViewController>(of type: T.Type) -> UIViewController? {
        return viewControllers.last(where: { $0.isKind(of: type) })
    }

    func lastViewControllerIndex<T: UIViewController>(of type: T.Type) -> Int? {
        return viewControllers.lastIndex(where: { $0.isKind(of: type) })
    }

    func newStack(viewControllerType: UIViewController.Type) -> [UIViewController] {
        let oldStack = self.viewControllers
        var newStack = oldStack
        while let lastViewController = newStack.last,
              type(of: lastViewController) != viewControllerType {
            _ = newStack.popLast()
        }
        return newStack.isEmpty ? oldStack : newStack
    }
}
