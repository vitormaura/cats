import Foundation
import RouterIdentifier

public class AnyRoute: Decodable {
    private enum CodingKeys: String, CodingKey {
        case identifier
    }

    public var route: Route?
    public let identifier: String?

    public init(route: Route?) {
        self.route = route
        self.identifier = nil
    }

    public init(identifier: any RouteIdentifier, content: Encodable? = nil) {
        let routeContent = RouteContent(identifier: identifier, content: content)
        if let routeData = try? JSONEncoder().encode(routeContent) {
            self.identifier = identifier.rawValue
            self.route = try? JSONDecoder().decode(AnyRoute.self, from: routeData).route
        } else {
            self.route = nil
            self.identifier = nil
        }
    }

    public required init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let identifier = try container.decode(String.self, forKey: .identifier)
            self.identifier = identifier
            self.route = RouteParser.instance.route(from: decoder, with: identifier)
        } catch {
            self.route = nil
            self.identifier = nil
        }
    }
}

