import Models
import SwiftUI

struct GridWidgetModel: WidgetModel {
    var viewType = GridWidgetView.self
    var id: String = UUID().uuidString
    var widgets: [any WidgetModel]
    var delegate: GridWidgetViewDelegate?
}

extension GridWidgetModel: WidgetHasSearchableVisitor {
    func searchBy(text: String, on visitor: HomeSearchableVisitor) -> (any WidgetModel)? {
        visitor.searchBy(text: text, on: self)
    }
}
