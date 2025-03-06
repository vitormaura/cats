import RouterBuilder
import RouterProtocol

public protocol DecodableRoute: Route {
    init(from decoder: Decoder, featureBuilder: FeatureBuilderProtocol?, dependencies: Dependencies, featureTypes: [FeatureTypeProtocol]) throws
}
