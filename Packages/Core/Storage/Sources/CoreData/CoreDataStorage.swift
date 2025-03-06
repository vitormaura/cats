import Foundation

final class CoreDataStorage: Storage {
    private let coreDataManager: CoreDataManagerProtocol

    init(coreDataManager: CoreDataManagerProtocol) {
        self.coreDataManager = coreDataManager
    }

    func write(_ data: Data, for key: String) {
        do {
            coreDataManager.save(data, for: key)
        } catch {
            debugPrint(error.localizedDescription)
        }
    }

    func clear(key: String) {
        coreDataManager.delete(key)
    }

    func clearAll() {
        let result = coreDataManager.fetchAll()
        result?.forEach {
            coreDataManager.delete($0.key)
        }
    }

    func keys() -> [String] {
        let result = coreDataManager.fetchAll()
        return result?.compactMap {
            $0.key
        } ?? []
    }

    func get(_ key: String) -> Data? {
        guard let data = coreDataManager.fetchBy(key)?.value else {
            return nil
        }
        do {
            return data
        } catch {
            debugPrint(error.localizedDescription)
            return nil
        }
    }
}

