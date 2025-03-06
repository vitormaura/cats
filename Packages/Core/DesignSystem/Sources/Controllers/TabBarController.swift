import SwiftUI

open class TabBarController: UITabBarController {
    private var tintColor: UIColor = .systemBackground.withAlphaComponent(0.9)
    private var titleColor: UIColor = .systemOrange

    public override init(nibName nibNameOrNil: String? = nil,
                         bundle nibBundleOrNil: Bundle? = nil) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    public required init?(coder: NSCoder) {
        fatalError()
    }

    deinit {
        print("-- deinit \(self) --")
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    private func setupTabBar() {
        tabBar.backgroundColor = .clear
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        tabBar.tintColor = self.titleColor
        setupIfNeeded()
    }

    private func setupIfNeeded() {
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = self.tintColor
        appearance.backgroundImage = nil
        appearance.shadowImage = nil
        appearance.shadowColor = nil
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = tabBar.standardAppearance
    }
}

