import Foundation
import RouterIdentifier
import RouterProtocol

enum TabModel: CaseIterable {
    case home
    case favourites

    var tab: Tab {
        switch self {
        case .home:
            return Tab(image: "cat.fill",
                       text: "CATS",
                       isEnabled: true,
                       route: AnyRoute(identifier: HomeRouteIdentifier.homeScreen))
        case .favourites:
            return Tab(image: "star.fill",
                       text: "FAVOURITES",
                       isEnabled: true,
                       route: AnyRoute(identifier: FavouritesRouteIdentifier.favouritesScreen))
        }
    }
}
