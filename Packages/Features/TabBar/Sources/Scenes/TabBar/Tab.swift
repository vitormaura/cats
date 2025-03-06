import Foundation
import RouterProtocol

struct Tab: Codable {
    private enum CodingKeys: String, CodingKey {
        case image, text, isEnabled, route
    }

    var image: String?
    var text: String?
    var isEnabled: Bool
    var route: AnyRoute

    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<CodingKeys> = try decoder.container(keyedBy: CodingKeys.self)
        self.image = try container.decodeIfPresent(String.self, forKey: .image)
        self.text = try container.decodeIfPresent(String.self, forKey: .text)
        self.isEnabled = try container.decode(Bool.self, forKey: .isEnabled)
        self.route = try container.decode(AnyRoute.self, forKey: .route)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(image, forKey: .image)
        try container.encodeIfPresent(text, forKey: .text)
        try container.encode(isEnabled, forKey: .isEnabled)
        try container.encode(route as? RouteContent, forKey: .route)
    }

    init(image: String?, text: String?, isEnabled: Bool, route: AnyRoute) {
        self.image = image
        self.text = text
        self.isEnabled = isEnabled
        self.route = route
    }
}

