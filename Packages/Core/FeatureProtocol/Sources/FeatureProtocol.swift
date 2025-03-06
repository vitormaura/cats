import Foundation
import RouterProtocol

public protocol FeatureProtocol: AnyObject {
    static func isEnabled(withIdentifier id: String) -> Bool

    func initialRoute(associatedTabIndex: Int?) -> Route?
    func route(from decoder: Decoder,
               with identifier: String,
               associatedTabIndex: Int?) throws -> Route?
}
