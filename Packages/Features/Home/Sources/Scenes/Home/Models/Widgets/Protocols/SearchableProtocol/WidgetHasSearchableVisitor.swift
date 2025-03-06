import Foundation
import Models

protocol WidgetHasSearchableVisitor {
    func searchBy(text: String, on visitor: HomeSearchableVisitor) -> (any WidgetModel)?
}
