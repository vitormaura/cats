import Models

protocol WidgetHasTappableVisitor {
    func onTap(from visitor: HomeTappableVisitor)
}
