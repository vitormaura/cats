import Foundation

public struct JSONBodyParameterEncoder: ParameterEncoder {
    public let parameters: [String: Any]

    public init(parameters: [String: Any]) {
        self.parameters = parameters
    }
}
