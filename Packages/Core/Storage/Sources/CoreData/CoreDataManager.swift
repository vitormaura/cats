import CoreData
import Foundation

public final class CoreDataManager: CoreDataManagerProtocol {
    private let persistentContainer: PersistentContainerProtocol

    public init(persistentContainer: PersistentContainerProtocol) {
        self.persistentContainer = persistentContainer
    }

    public func save(_ data: Data, for key: String) {
        let object = CoreDataModel(key: key, value: data)
        if let result = fetchUniqueFromDataBase(key) {
            updateValuesAndSaveContext(result, with: object)
        } else {
            create(object)
        }
    }

    private func create(_ object: CoreDataModelProtocol) {
        let dataBase = Database(context: persistentContainer.context)
        updateValuesAndSaveContext(dataBase, with: object)
    }

    private func updateValuesAndSaveContext(_ objectDataBase: Database, with objectToUpdate: CoreDataModelProtocol) {
        objectDataBase.key = objectToUpdate.key
        objectDataBase.value = objectToUpdate.value
        saveContext()
    }

    public func fetchBy(_ key: String) -> CoreDataModelProtocol? {
        guard let result = fetchUniqueFromDataBase(key),
              let key = result.key,
              let value = result.value else {
            return nil
        }
        return CoreDataModel(key: key, value: value)
    }

    private func fetchUniqueFromDataBase(_ key: String) -> Database? {
        let predicate = NSPredicate(format: "key = %@", key)
        let result: Database? = fetchListFromDataBase(Database.self, predicate: predicate)?.first
        return result
    }

    public func fetchAll() -> [CoreDataModelProtocol]? {
        let result: [Database]? = fetchListFromDataBase(Database.self)
        return result?.compactMap {
            guard let key = $0.key, let value = $0.value else {
                return nil
            }
            return CoreDataModel(key: key, value: value)
        }
    }

    private func fetchListFromDataBase<T: NSManagedObject> (_ type: T.Type, predicate: NSPredicate? = nil) -> [T]? {
        let fetchRequest: NSFetchRequest<T> = NSFetchRequest<T>(entityName: String(describing: T.self))
        fetchRequest.predicate = predicate
        do {
            return try persistentContainer.context.fetch(fetchRequest)
        } catch {
            print(error)
            return nil
        }
    }

    public func delete(_ key: String) {
        guard let result = fetchUniqueFromDataBase(key) else {
            return
        }
        persistentContainer.context.delete(result)
        saveContext()
    }

    private func saveContext() {
        let context = persistentContainer.context
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
    }
}
