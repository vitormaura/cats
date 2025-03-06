import Foundation
import RouterProtocol

public protocol RouterBuilderProtocol {
    func route(from decoder: Decoder, with identifier: String) -> Route?
}
