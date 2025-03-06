import SwiftUI
import RouterProtocol

class DescriptionRoute: DecodableRoute {
    var associatedTabIndex: Int?
    var dependencies: Dependencies
    var type: CombinedRouteTypeProtocol

    enum CodingKeys: String, CodingKey {
        case content
    }

    let content: DescriptionModel

    init(type: CombinedRouteTypeProtocol = CombinedRouteType(routes: [.push]),
         dependencies: Dependencies,
         content: DescriptionModel,
         associatedTabIndex: Int?) {
        self.type = type
        self.dependencies = dependencies
        self.content = content
        self.associatedTabIndex = associatedTabIndex
    }

    required init(from decoder: Decoder,
                  dependencies: Dependencies,
                  associatedTabIndex: Int?) throws {
        self.type = CombinedRouteType(routes: [.push])
        self.dependencies = dependencies
        self.associatedTabIndex = associatedTabIndex
        let decoderContainer = try decoder.container(keyedBy: CodingKeys.self)
        self.content = try decoderContainer.decode(DescriptionModel.self, forKey: .content)
    }

    func route(from rootViewController: UIViewController,
               with navigation: RouterProtocol) -> UIViewController? {
        return DescriptionBuilder.createRoute(content: content,
                                              dependencies: dependencies)
    }
}
