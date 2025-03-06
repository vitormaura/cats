import SwiftUI

public protocol RouterProtocol {
    func handle(_ route: Route?, animated: Bool, rootViewController: UIViewController)
}
