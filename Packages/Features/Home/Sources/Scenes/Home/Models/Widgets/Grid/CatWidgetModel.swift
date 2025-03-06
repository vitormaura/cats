import SwiftUI
import Models

struct CatWidgetModel: WidgetModel {
    var viewType = CatWidgetView.self
    var id: String
    var imageURL: String?
    var name: String
    var isFavorite: Bool
    var delegate: CatWidgetViewDelegate?
}

extension CatWidgetModel: WidgetHasSearchableVisitor {
    func searchBy(text: String, on visitor: HomeSearchableVisitor) -> (any WidgetModel)? {
        visitor.searchBy(text: text, on: self)
    }
}

extension CatWidgetModel: WidgetHasPresentableVisitor {
    func onAppear(using visitor: HomePresentableVisitor) {
        visitor.onApper(with: self)
    }
}

extension CatWidgetModel: WidgetHasTappableVisitor {
    func onTap(from visitor:  HomeTappableVisitor) {
        visitor.onTap(from: self)
    }
}
