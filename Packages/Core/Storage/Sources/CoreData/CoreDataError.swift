import Foundation

public enum CoreDataError: Error {
    case createContainerWithFileProtectionError
    case loadPersistentStoresError
    case genericErrror
}

extension CoreDataError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .createContainerWithFileProtectionError:
            return "An error occurred creating PersistentContainer with FileProtectionType"
        case .loadPersistentStoresError:
            return "An error occurred while creating PersistentContainer without FileProtectionType using loadPersistentStores"
        default:
            return "Generic error in CoreData"
        }
    }
}
