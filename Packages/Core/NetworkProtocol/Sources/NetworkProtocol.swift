import Foundation

public protocol NetworkProtocol: AnyObject {
    var baseURL: URL { get }
    var defaultHeaders: [String: String] { get }
    @MainActor func send<R>(_ resource: R) async throws -> R.Value where R: RequestProtocol
    func cancel<R>(_ resource: R) where R: RequestProtocol
    func add(defaultHeader header: String, value: String)
    func remove(defaultHeader header: String)
    func set(defaultHeaders: [String: String])
}

public extension NetworkProtocol {
    @MainActor
    public func send<R>(_ resource: R) async throws -> R.Value where R: RequestProtocol {
        return try await send(resource)
    }
}
