import Foundation

struct AnyEncodable: Encodable {
    private let value: Encodable
    
    init<T: Encodable>(_ value: T) {
        self.value = value
    }
    
    func encode(to encoder: Encoder) throws {
        try value.encode(to: encoder)
    }
}
