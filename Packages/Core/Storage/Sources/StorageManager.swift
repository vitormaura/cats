import Foundation
import StorageProtocol

public final class StorageManager: StorageManagerProtocol {
    private var storageFactory: StorageFactoryProtocol

    public init(storageFactory: StorageFactoryProtocol) {
        self.storageFactory = storageFactory
    }

    public func persist<T>(_ value: T?, key: String, storageType: StorageType) where T: Codable {
        let storage = storageFactory.storage(of: storageType)

        guard let value else {
            return
        }

        guard let data = convertToData(value) else {
            return
        }

        storage.write(data, for: key)
    }

    private func convertToData<T: Codable>(_ value: T) -> Data? {
        let entry = StorageEntry(value: value)
        return try? JSONEncoder().encode(entry)
    }

    public func retrieve<T>(_ key: String, storageType: StorageType) -> T? where T: Codable {
        let storage = storageFactory.storage(of: storageType)
        return self.retrieve(key, storage: storage)
    }

    private func retrieve<T>(_ key: String, storage: Storage) -> T? where T: Codable {
        guard let data = storage.get(key),
              let storageEntry: StorageEntry<T> = entry(from: data) else {
            return nil
        }

        return storageEntry.value
    }

    private func entry<T: Codable>(from data: Data) -> StorageEntry<T>? {
        return try? JSONDecoder().decode(StorageEntry<T>.self, from: data)
    }

    public func clearAll(storageType: StorageType) {
        let storage = storageFactory.storage(of: storageType)
        storage.clearAll()
    }

    public func all<T>(storageType: StorageType) -> [String: T] where T: Codable {
        let storage = storageFactory.storage(of: storageType)
        let keys = storage.keys()
        return keys.reduce([:]) { result, key -> [String: T] in
            guard let value: T = self.retrieve(key, storage: storage) else {
                return result
            }

            var dict = result
            dict[key] = value
            return dict
        }
    }
}
