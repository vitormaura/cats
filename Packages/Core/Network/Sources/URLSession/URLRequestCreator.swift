import Foundation
import NetworkProtocol

final class URLRequestCreator: URLRequestCreatorProtocol {
    private let baseURL: URL

    init(baseURL: URL) {
        self.baseURL = baseURL
    }

    func createURLRequest<R>(for resource: R,
                             defaultHeaders: [String: String]) throws -> URLRequest where R: RequestProtocol
    {
        let urlRequest = try self.urlRequest(for: resource, defaultHeaders: defaultHeaders)
        return try mutatedURLRequest(from: urlRequest, for: resource)
    }

    private func urlRequest<R>(for resource: R,
                               defaultHeaders: [String: String]) throws -> URLRequest where R: RequestProtocol
    {
        let baseURL = try self.baseURL(from: resource)
        var urlRequest = URLRequest(url: baseURL)
        urlRequest.httpMethod = resource.method.rawValue
        urlRequest.timeoutInterval = resource.timeoutInterval
        urlRequest.allHTTPHeaderFields = defaultHeaders.merging(resource.headers) { _ , new -> String in
            new
        }
        return urlRequest
    }

    private func baseURL<R: RequestProtocol>(from resource: R) throws -> URL
    {
        let baseURL = resource.baseURL ?? self.baseURL
        guard let url = URL(string: baseURL.absoluteString + resource.path) else {
            throw NetworkError.generic
        }
        return url
    }

    private func mutatedURLRequest<R: RequestProtocol>(from urlRequest: URLRequest,
                                                       for resource: R) throws -> URLRequest
    {
        let parameterEncoder = resource.parameterEncoder as? MutableParameterEncoder
        return try parameterEncoder?.mutate(urlRequest: urlRequest) ?? urlRequest
    }
}
