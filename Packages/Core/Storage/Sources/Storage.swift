import Foundation

public protocol Storage {
    func write(_ data: Data, for key: String)
    func clear(key: String)
    func clearAll()
    func keys() -> [String]

    func get(_ key: String) -> Data?
}
