import CoreData
import Foundation

public protocol ManagedObjectContextProtocol where Self: NSManagedObjectContext {
    func fetch<T>(_ request: NSFetchRequest<T>) throws -> [T] where T: NSFetchRequestResult
    func delete(_ object: NSManagedObject)
    func save() throws
    var hasChanges: Bool { get }
}

extension NSManagedObjectContext: ManagedObjectContextProtocol {}
