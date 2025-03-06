import Foundation

public protocol URLRequestCreatorProtocol {
    func createURLRequest<R: RequestProtocol>(for resource: R,
                                              defaultHeaders: [String: String]) throws -> URLRequest
}
