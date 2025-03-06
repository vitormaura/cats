import Models
import SwiftUI

public struct AnyWidgetView: View {
    private let _view: any View

    public init<Model: WidgetModel>(_ widget: Model) {
        guard let typedModel = widget as? Model.ViewType.Model else {
            self._view = Text("Error loading view")
            return
        }

        self._view = widget.viewType.init(model: typedModel)
    }

    public var body: some View {
        AnyView(_view)
    }
}
