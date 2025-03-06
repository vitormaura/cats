import SwiftUI
import RouterProtocol
import DesignSystem

final class WindowInitializer {
    private let featureBuilder: FeatureBuilder
    var window: UIWindow?

    init(featureBuilder: FeatureBuilder) {
        self.featureBuilder = featureBuilder
    }

    func configure(window: UIWindow?) {
        self.window = window
        let navigationController = NavigationController()
        window?.rootViewController = navigationController

        var initialRoute = featureBuilder.feature(type: FeatureType.tabBar)?
            .initialRoute(associatedTabIndex: nil)
        initialRoute?.type = CombinedRouteType(routes: [.push])

        featureBuilder.container.router.handle(initialRoute,
                                               animated: true,
                                               rootViewController: navigationController)
        window?.makeKeyAndVisible()
    }
}
