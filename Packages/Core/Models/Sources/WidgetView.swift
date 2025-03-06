import SwiftUI

public protocol WidgetView where Self: View {
    associatedtype Model: WidgetModel
    var model: Model { get }

    init(model: Model)
}
