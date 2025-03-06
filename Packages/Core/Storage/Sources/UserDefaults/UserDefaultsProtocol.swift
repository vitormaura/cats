import Foundation

protocol UserDefaultsProtocol {
    func value(forKey key: String) -> Any?
    func set(_ value: Any?, forKey defaultName: String)
    func object(forKey defaultName: String) -> Any?
    func removeObject(forKey defaultName: String)
}

extension UserDefaults: UserDefaultsProtocol { }
