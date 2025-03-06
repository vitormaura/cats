import Foundation
import NetworkProtocol

protocol MutableParameterEncoder: ParameterEncoder {
    func mutate(urlRequest: URLRequest) throws -> URLRequest
}
