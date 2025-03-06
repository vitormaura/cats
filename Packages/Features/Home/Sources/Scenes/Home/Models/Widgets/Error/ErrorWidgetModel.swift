import Models
import SwiftUI

struct ErrorWidgetModel: WidgetModel {
    var viewType = ErrorWidgetView.self
    var id: String = UUID().uuidString
    var title: String = "Oops!"
    var subtitle: String = "Something went wrong."
    var buttonTitle: String = "Try again"
}

extension ErrorWidgetModel: WidgetHasTappableVisitor {
    func onTap(from visitor:  HomeTappableVisitor) {
        visitor.onTap(from: self)
    }
}
