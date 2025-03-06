import DesignSystem
import Models
import SwiftUI

struct ErrorWidgetView: WidgetView {
    var model: ErrorWidgetModel
    
    var body: some View {
        VStack(spacing: 12) {
            VStack(spacing: 4) {
                Text(model.title)
                    .font(.headline)
                Text(model.subtitle)
                    .font(.caption)
            }
            Text(model.buttonTitle)
                .font(.caption)
                .foregroundColor(.blue)
        }
        .padding(32)
    }
}
