import Foundation

final class UserDefaultStorage: Storage {
    private let userDefaults: UserDefaultsProtocol
    private let keysTrackerId: String

    init(userDefaults: UserDefaultsProtocol = UserDefaults.standard,
         keysTrackerId: String = "CatsAppKeys")
    {
        self.userDefaults = userDefaults
        self.keysTrackerId = keysTrackerId
    }

    private var allKeys: [String] {
        get {
            return userDefaults.value(forKey: keysTrackerId) as? [String] ?? []
        }
        set {
            userDefaults.set(newValue, forKey: keysTrackerId)
        }
    }

    func get(_ key: String) -> Data? {
        return userDefaults.object(forKey: key) as? Data
    }

    func write(_ data: Data, for key: String) {
        self.userDefaults.set(data, forKey: key)
        self.addKeyIfNeeded(key)
    }

    private func addKeyIfNeeded(_ key: String) {
        if !allKeys.contains(key) {
            allKeys.append(key)
        }
    }

    func clear(key: String) {
        self.userDefaults.removeObject(forKey: key)
        allKeys.removeAll { $0 == key }
    }

    func clearAll() {
        let allKeys = self.allKeys
        for key in allKeys {
            self.userDefaults.removeObject(forKey: key)
        }
        self.allKeys = []
    }

    func keys() -> [String] {
        return self.allKeys
    }
}
