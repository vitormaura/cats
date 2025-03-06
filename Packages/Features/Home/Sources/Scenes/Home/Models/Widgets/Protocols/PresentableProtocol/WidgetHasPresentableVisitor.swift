import Models

protocol WidgetHasPresentableVisitor {
    func onAppear(using visitor: HomePresentableVisitor)
}
