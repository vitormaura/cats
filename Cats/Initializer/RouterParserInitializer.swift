import RouterBuilder
import RouterProtocol

final class RouterParserInitializer {
    private let featureBuilder: FeatureBuilder

    init(featureBuilder: FeatureBuilder) {
        self.featureBuilder = featureBuilder
    }

    func configure() {
        let routerBuilder = RouterBuilder(featureBuilder: featureBuilder,
                                          features: FeatureType.allCases)
        RouteParser.instance.routerBuilder = routerBuilder
    }
}
