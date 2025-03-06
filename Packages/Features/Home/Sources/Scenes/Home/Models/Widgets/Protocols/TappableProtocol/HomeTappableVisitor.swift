import Models

protocol HomeTappableVisitor {
    func onTap(from widget: CatWidgetModel)
    func onTap(from widget: ErrorWidgetModel)
}
