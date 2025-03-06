import Foundation
import RouterIdentifier

public struct RouteContent: Encodable {
    private enum CodingKeys: String, CodingKey {
        case identifier
        case content
    }

    private let identifier: String
    private let content: Encodable?

    public init(identifier: any RouteIdentifier, content: Encodable? = nil) {
        self.identifier = identifier.rawValue as? String ?? ""
        self.content = content
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(identifier, forKey: .identifier)
        if let content = content {
            try container.encodeIfPresent(content, forKey: .content)
        }
    }
}

