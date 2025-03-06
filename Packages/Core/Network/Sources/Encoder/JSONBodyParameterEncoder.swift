import Foundation
import NetworkProtocol

extension JSONBodyParameterEncoder: MutableParameterEncoder {
    func mutate(urlRequest: URLRequest) throws -> URLRequest {
        let newURLRequest = urlRequestSettingHeader(of: urlRequest,
                                                    key: "Content-Type",
                                                    value: "application/json")
        return try urlRequestWithContentEncoding(urlRequest: newURLRequest)
    }

    private func urlRequestSettingHeader(of urlRequest: URLRequest, key: String, value: String) -> URLRequest {
        var newURLRequest = urlRequest
        if var headers = newURLRequest.allHTTPHeaderFields {
            headers[key] = value
            newURLRequest.allHTTPHeaderFields = headers
        } else {
            newURLRequest.allHTTPHeaderFields = [key: value]
        }

        return newURLRequest
    }

    private func urlRequestWithContentEncoding(urlRequest: URLRequest) throws -> URLRequest {
        var newURLRequest = urlRequest
        let httpBody: Data? = try self.httpBody()
        newURLRequest.httpBody = httpBody
        return newURLRequest
    }

    private func httpBody() throws -> Data? {
        let options: JSONSerialization.WritingOptions = .init(rawValue: 0)
        let data = try JSONSerialization.data(withJSONObject: self.parameters, options: options)
        return data
    }
}
