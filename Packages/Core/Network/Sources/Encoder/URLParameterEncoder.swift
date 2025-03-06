import Foundation
import NetworkProtocol

extension URLParameterEncoder: MutableParameterEncoder {
    func mutate(urlRequest: URLRequest) throws -> URLRequest {
        guard let url = urlRequest.url,
              var urlComponents = URLComponents(string: url.absoluteString) else {
            return urlRequest
        }

        var queryItems = [URLQueryItem]()
        for tuple in parameters {
            for value in ((tuple.value as? [Any]) ?? [tuple.value]) {
                let query = URLQueryItem(name: tuple.key, value: String(describing: value))
                queryItems.append(query)
            }
        }
        urlComponents.queryItems = (urlComponents.queryItems ?? []) + queryItems

        var newURLRequest = urlRequest
        newURLRequest.url = urlComponents.url
        return newURLRequest
    }
}
