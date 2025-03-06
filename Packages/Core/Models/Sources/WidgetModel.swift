import SwiftUI

public protocol WidgetModel: Identifiable, Equatable, Hashable {
    associatedtype ViewType: WidgetView
    var viewType: ViewType.Type { get }
    var id: String { get }
}

extension WidgetModel {
    public static func ==(lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
