import Models
import SwiftUI

struct LoadingWidgetModel: WidgetModel {
    var viewType = LoadingWidgetView.self
    var id: String = UUID().uuidString
}
