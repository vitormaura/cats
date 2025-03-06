import FeatureProtocol

public struct FeatureConfiguration {
    public let metatype: FeatureProtocol.Type
    public var associatedTab: Int?

    public init(metatype: FeatureProtocol.Type, associatedTab: Int? = nil) {
        self.metatype = metatype
        self.associatedTab = associatedTab
    }
}
