import Foundation

public protocol RequestProtocol {
    associatedtype Value = Data

    var method: Method { get }
    var path: String { get }
    var baseURL: URL? { get }
    var timeoutInterval: TimeInterval { get }
    var headers: [String: String] { get }
    var parameterEncoder: ParameterEncoder? { get }

    func serialize(data: Data) throws -> Value
}

public extension RequestProtocol {
    var baseURL: URL? {
        return nil
    }

    var timeoutInterval: TimeInterval {
        return 30.0
    }

    var headers: [String: String] {
        return [:]
    }
}

public extension RequestProtocol where Value == Data {
    func serialize(data: Data) throws -> Value {
        return data
    }
}

public extension RequestProtocol where Value == URL {
    func serialize(data: URL?) throws -> Value? {
        return data
    }
}

public extension RequestProtocol where Value: Decodable {
    func serialize(data: Data) throws -> Value {
        return try JSONDecoder().decode(Value.self, from: data)
    }
}

public extension RequestProtocol where Value == Void {
    func serialize(data: Data) throws -> Value {
        return
    }
}

extension Swift.Error {
    var httpCode: Int {
        return (self as NSError).code
    }
}
