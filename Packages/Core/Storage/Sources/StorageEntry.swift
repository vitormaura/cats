import Foundation

struct StorageEntry<T: Codable>: Codable {
    public let value: T

    public init(value: T) {
        self.value = value
    }
}
