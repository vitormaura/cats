import CoreData
import Foundation

public final class PersistentContainer: NSPersistentContainer {
    public init() {
        guard let urls = Bundle.module.urls(forResourcesWithExtension: "momd", subdirectory: nil),
              urls.isEmpty == false else {
            fatalError("Couldn't find any .momd files in the bundle.")
        }

        let models = urls.compactMap( { NSManagedObjectModel(contentsOf: $0) })

        guard let managedObjectModel = NSManagedObjectModel(byMerging: models) else {
            fatalError("Couldn't find any .momd files in the bundle.")
        }

        super.init(name: "Model", managedObjectModel: managedObjectModel)
        setup()
    }

    private func setup() {
        do {
            try setupWithFileProtection()
        } catch {
            setupDefaultLoad()
        }
        setupContext()
    }

    private func setupWithFileProtection() throws {
        guard let url = persistentStoreDescriptions.first?.url else {
            throw CoreDataError.createContainerWithFileProtectionError
        }

        let options: [AnyHashable: Any] = [NSPersistentStoreFileProtectionKey: FileProtectionType.none]
        do {
            try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                                                              configurationName: nil,
                                                              at: url,
                                                              options: options)
        } catch  {
            throw CoreDataError.createContainerWithFileProtectionError
        }
    }

    private func setupDefaultLoad() {
        loadPersistentStores { _, error in
            if let error = error as NSError? {
                print(error)
            }
        }
    }

    private func setupContext() {
        viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        viewContext.undoManager = nil
        viewContext.shouldDeleteInaccessibleFaults = true
        viewContext.automaticallyMergesChangesFromParent = true
    }
}

extension PersistentContainer: PersistentContainerProtocol {
    public var context: ManagedObjectContextProtocol {
        viewContext
    }

    public func backgroundContext() -> ManagedObjectContextProtocol {
        newBackgroundContext()
    }
}
