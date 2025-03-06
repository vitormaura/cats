import Foundation
import Models

protocol HomeSearchableVisitor {
    func searchBy(text: String, on widget: GridWidgetModel) -> (any WidgetModel)?
    func searchBy(text: String, on widget: CatWidgetModel) -> (any WidgetModel)?
}
