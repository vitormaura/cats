import SwiftUI

extension UINavigationController: ViewControllerStack {
    var navigation: UINavigationController {
        return self
    }
}
