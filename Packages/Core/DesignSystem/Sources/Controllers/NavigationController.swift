import SwiftUI

open class NavigationController: UINavigationController {
    private var tintColor: UIColor = .systemOrange.withAlphaComponent(0.9)
    private var titleColor: UIColor = .label

    override open func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        setupLargeTitles()
        setupAppearance()
    }

    public func setupLargeTitles() {
        navigationBar.tintColor = titleColor
        navigationBar.prefersLargeTitles = true
    }

    public func setupAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = tintColor

        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
    }
}
