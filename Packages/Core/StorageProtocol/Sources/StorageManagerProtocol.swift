import Foundation

public protocol StorageManagerProtocol: AnyObject  {
    func persist<T>(_ value: T?, key: String, storageType: StorageType) where T: Codable
    func retrieve<T>(_ key: String, storageType: StorageType) -> T? where T: Codable
    func clearAll(storageType: StorageType)
    func all<T>(storageType: StorageType) -> [String: T] where T: Codable
}
