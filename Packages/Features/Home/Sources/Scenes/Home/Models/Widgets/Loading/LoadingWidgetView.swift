import DesignSystem
import Models
import SwiftUI

struct LoadingWidgetView: WidgetView {
    var model: LoadingWidgetModel

    var body: some View {
        Group {
            LoadingView(width: 24, height: 24)
        }
        .padding(32)
    }
}
