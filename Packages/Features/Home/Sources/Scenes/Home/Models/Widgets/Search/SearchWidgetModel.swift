import Models
import SwiftUI

struct SearchWidgetModel: WidgetModel {
    var viewType = SearchWidgetView.self
    var id: String = UUID().uuidString
    var placeholder: String = "Search..."
    var delegate: SearchWidgetViewDelegate?
}
