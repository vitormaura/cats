import CoreData
import Foundation

public protocol PersistentContainerProtocol where Self: NSPersistentContainer {
    var context: ManagedObjectContextProtocol { get }
    func backgroundContext() -> ManagedObjectContextProtocol
}
