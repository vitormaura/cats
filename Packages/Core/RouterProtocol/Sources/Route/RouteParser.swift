import Foundation

public class RouteParser {
    nonisolated(unsafe) public static let instance: RouteParser = RouteParser()
    public var routerBuilder: RouterBuilderProtocol?

    private init() { }

    func route(from decoder: Decoder, with identifier: String) -> Route? {
        return routerBuilder?.route(from: decoder, with: identifier)
    }
}
