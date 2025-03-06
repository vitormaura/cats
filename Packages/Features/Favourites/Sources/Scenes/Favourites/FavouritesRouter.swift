import Foundation
import RouterIdentifier
import RouterProtocol
import SwiftUI

protocol FavouritesRouterProtocol {
    func goToDescriptionRoute(content: Encodable)
}

final class FavouritesRouter: FavouritesRouterProtocol {
    private let router: RouterProtocol
    weak var viewController: UIViewController?

    init(router: RouterProtocol) {
        self.router = router
    }

    func goToDescriptionRoute(content: Encodable) {
        guard let viewController  else {
            return
        }

        let route = AnyRoute(identifier: DescriptionRouteIdentifier.descriptionScreen,
                             content: content).route
        router.handle(route, animated: true, rootViewController: viewController)
    }
}
