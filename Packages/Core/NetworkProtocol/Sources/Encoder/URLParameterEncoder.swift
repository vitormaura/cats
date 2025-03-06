import Foundation

public struct URLParameterEncoder: ParameterEncoder {
    public let parameters: [String: Any]

    public init(parameters: [String: Any]) {
        self.parameters = parameters
    }
}
