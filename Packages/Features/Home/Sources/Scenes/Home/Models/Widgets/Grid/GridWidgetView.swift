import DesignSystem
import Models
import SwiftUI

protocol GridWidgetViewDelegate {
    func onAppearWidget<Widget: WidgetModel>(_ widget: Widget)
    func onTapWidget<Widget: WidgetModel>(_ widget: Widget)
}

struct GridWidgetView: WidgetView {
    var model: GridWidgetModel

    let columns = [
        GridItem(.flexible(), alignment: .top),
        GridItem(.flexible(), alignment: .top),
    ]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 24) {
            ForEach(model.widgets, id: \.id) { widget in
                AnyWidgetView(widget)
                    .onAppear {
                        model.delegate?.onAppearWidget(widget)
                    }.onTapGesture {
                        model.delegate?.onTapWidget(widget)
                    }
            }
        }
    }
}
