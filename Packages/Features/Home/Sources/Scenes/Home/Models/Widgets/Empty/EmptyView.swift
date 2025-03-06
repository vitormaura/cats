import DesignSystem
import Models
import SwiftUI

struct EmptyWidgetView: WidgetView {
    var model: EmptyWidgetModel
    
    var body: some View {
        VStack(spacing: 12) {
            model.image
                .resizable()
                .renderingMode(.template)
                .foregroundColor(.orange)
                .frame(width: 80, height: 80)
            Text(model.title)
                .font(.headline)
        }
        .padding(32)
    }
}
