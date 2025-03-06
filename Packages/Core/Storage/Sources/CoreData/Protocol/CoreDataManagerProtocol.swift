import CoreData
import Foundation

public protocol CoreDataManagerProtocol {
    func save(_ data: Data, for key: String)
    func fetchBy(_ key: String) -> CoreDataModelProtocol?
    func fetchAll() -> [CoreDataModelProtocol]?
    func delete(_ key: String)
}
