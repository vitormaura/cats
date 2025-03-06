import Foundation

public class DynamicEncodable: Encodable {
    private struct CodingKeyWrapper: CodingKey {
        var stringValue: String
        var intValue: Int? { return nil }
        
        init(_ string: String) {
            self.stringValue = string
        }
        
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        
        init?(intValue: Int) {
            return nil
        }
    }

    public init() { }

    private var storage: [String: AnyEncodable] = [:]
    
    public func setValue<T: Encodable>(_ value: T, forKey key: String) {
        storage[key] = AnyEncodable(value)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeyWrapper.self)
        for (key, value) in storage {
            try container.encode(value, forKey: CodingKeyWrapper(key))
        }
    }
}
