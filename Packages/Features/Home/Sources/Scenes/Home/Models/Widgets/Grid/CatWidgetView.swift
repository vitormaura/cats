import SwiftUI
import DesignSystem
import Models

protocol CatWidgetViewDelegate {
    func buttonAction(widget:  CatWidgetModel)
}

struct CatWidgetView: WidgetView {
    var model: CatWidgetModel

    var body: some View {
        CardView(imageURL: model.imageURL,
                 placeholder: .init(systemName: "cat.fill"),
                 title: model.name,
                 isFavourite: model.isFavorite,
                 buttonAction: {
            model.delegate?.buttonAction(widget: model)
        })
    }
}
