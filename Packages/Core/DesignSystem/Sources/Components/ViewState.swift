import Foundation

public enum ViewState: Equatable, Hashable {
    case loading
    case success
    case error(model: ErrorModel = ErrorModel())

    public static func == (lhs: ViewState, rhs: ViewState) -> Bool {
        lhs.hashValue == rhs.hashValue
    }

    public var hashValue: Int {
        return UUID().uuidString.hashValue
    }
}
