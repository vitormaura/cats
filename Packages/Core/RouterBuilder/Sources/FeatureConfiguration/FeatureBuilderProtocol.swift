import FeatureProtocol

public protocol FeatureBuilderProtocol: AnyObject {
    func feature(type: FeatureTypeProtocol) -> FeatureProtocol?
    func associateTabIndex(type: FeatureTypeProtocol, config: FeatureConfiguration)
    func resetAllTabIndexes()
}
