import Foundation

protocol RouteTypeProtocol {
    func newStackPerformingRoute(currentNavigationState: NavigationState) -> NavigationState
}
