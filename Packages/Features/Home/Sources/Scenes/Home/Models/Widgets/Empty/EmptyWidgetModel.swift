import Models
import SwiftUI

struct EmptyWidgetModel: WidgetModel {
    var viewType = EmptyWidgetView.self
    var id: String = UUID().uuidString
    var image: Image = .init(systemName: "cat")
    var title: String = "Oops! there is nothing here"
}
