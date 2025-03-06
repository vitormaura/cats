import Foundation
import FeatureProtocol
import RouterBuilder
import RouterProtocol

final class FeatureBuilder: FeatureBuilderProtocol {
    private(set) var container: DependencyContainerProtocol
    private let featureStore = FeatureStore()
    private var hasRegisteredFeature = false

    init() {
        self.container = DependencyContainer()
    }

    func feature(type: FeatureTypeProtocol) -> FeatureProtocol? {
        guard let type = type as? FeatureType else {
            return nil
        }

        registerFeaturesIfNeeded()
        return featureStore.features[type]?()
    }

    private func registerFeaturesIfNeeded() {
        guard hasRegisteredFeature == false else {
            return
        }

        registerFeatures()
    }

    private func registerFeatures() {
        hasRegisteredFeature = true
        container.featureBuilder = self
        featureStore.register(.home, container: container, keyPath: \.home)
        featureStore.register(.description, container: container, keyPath: \.description)
        featureStore.register(.favourites, container: container, keyPath: \.favourites)
        featureStore.register(.tabBar, container: container, keyPath: \.tabBar)
    }

    func associateTabIndex(type: FeatureTypeProtocol, config: FeatureConfiguration) {
        guard var type = type as? FeatureType,
              let entry = featureStore.features.removeValue(forKey: type) else {
            return
        }
 
        type.updateConfiguration(for: type, with: config)
        featureStore.features[type] = entry
    }

    func resetAllTabIndexes() {
        featureStore.features.enumerated().forEach({ index, item in
            guard let entry = featureStore.features.removeValue(forKey: item.key) else {
                return
            }
     
            var type = item.key
            type.updateConfiguration(for: type, with: .init(metatype: type.configuration.metatype))
            featureStore.features[type] = entry
        })
    }
}
