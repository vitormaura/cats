import Foundation

typealias Factory<T> = (DependencyContainerProtocol) -> T

@propertyWrapper
final class LazyInjection<T: AnyObject> {
    private var factory: Factory<T>
    private weak var _value: T?

    init(wrappedValue: @escaping Factory<T>) {
        self.factory = wrappedValue
    }

    var wrappedValue: Factory<T> {
        get {
            getValue
        }
        set {
            self.factory = newValue
        }
    }

    private func getValue(container: DependencyContainerProtocol) -> T {
        if let value = _value {
            return value
        } else {
            let value = factory(container)
            _value = value
            return value
        }
    }
}

