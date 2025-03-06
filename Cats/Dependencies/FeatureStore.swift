import FeatureProtocol
import RouterProtocol

final class FeatureStore {
    var features: [FeatureType: () -> FeatureProtocol?] = [:]

    func register<T: FeatureProtocol>(_ feature: FeatureType,
                                      container: DependencyContainerProtocol,
                                      keyPath: KeyPath<DependencyContainerProtocol, T>) {
        self.features[feature] = {
            container[keyPath: keyPath]
        }
    }
}
