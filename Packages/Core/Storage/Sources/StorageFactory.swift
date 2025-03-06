import Foundation
import StorageProtocol

public protocol StorageFactoryProtocol: AnyObject {
    func storage(of type: StorageType) -> Storage
}

public class StorageFactory: StorageFactoryProtocol {
    private let coreDataManager: CoreDataManagerProtocol

    public init(coreDataManager: CoreDataManagerProtocol){
        self.coreDataManager = coreDataManager
    }

    public func storage(of type: StorageType) -> Storage {
        switch type {
        case .coreData:
            return CoreDataStorage(coreDataManager: coreDataManager)
        case .userDefaults:
            return UserDefaultStorage()
        }
    }
}
