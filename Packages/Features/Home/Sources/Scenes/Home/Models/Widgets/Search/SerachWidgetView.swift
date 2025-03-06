import DesignSystem
import Models
import SwiftUI

protocol SearchWidgetViewDelegate {
    func onChange(_ text: String)
}

struct SearchWidgetView: WidgetView {
    var model: SearchWidgetModel
    @State private var searchText: String = ""

    init(model: SearchWidgetModel) {
        self.model = model
    }

    var body: some View {
        Group {
            CustomTextField(field: $searchText,
                            placeholder: model.placeholder,
                            onChange: model.delegate?.onChange)
        }
    }
}
