import SwiftUI
import RouterProtocol

final class AppInitializer {
    let routerParserInitializer: RouterParserInitializer
    let windowInitializer: WindowInitializer

    convenience init() {
        let featureBuilder = FeatureBuilder()
        let routerParserInitializer = RouterParserInitializer(featureBuilder: featureBuilder)
        let windowInitializer = WindowInitializer(featureBuilder: featureBuilder)
        self.init(routerParserInitializer: routerParserInitializer, windowInitializer: windowInitializer)
    }

    init(routerParserInitializer: RouterParserInitializer,
         windowInitializer: WindowInitializer) {
        self.routerParserInitializer = routerParserInitializer
        self.windowInitializer = windowInitializer
    }

    func configure(window: UIWindow?) {
        routerParserInitializer.configure()
        windowInitializer.configure(window: window)
    }
}
