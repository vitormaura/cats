import DesignSystem
import RouterProtocol
import SwiftUI

enum TabBarBuilder {
    static func createRoute(dependencies: Dependencies, tabs: [Tab]) -> UIViewController {
        let tabBarController = TabBarController()
        tabs.forEach({ addTab($0, to: tabBarController, dependencies: dependencies) })
        tabBarController.selectedIndex = 0

        return tabBarController
    }

    private static func addTab(_ tab: Tab,
                               to tabBarController: UITabBarController,
                               dependencies: Dependencies) {
        let navigationController = NavigationController()
        tabBarController.addChild(navigationController)
        dependencies.router.handle(tab.route.route,
                                   animated: true,
                                   rootViewController: navigationController)
        setupTabItem(for: tab, in: navigationController)
    }

    private static func setupTabItem(for tab: Tab, in navigationController: NavigationController) {
        let tabBarItem = UITabBarItem(title: tab.text,
                                      image: UIImage(systemName: tab.image ?? ""),
                                      selectedImage: UIImage(systemName: tab.image ?? ""))
        tabBarItem.isEnabled = tab.isEnabled
        navigationController.tabBarItem = tabBarItem
    }
}
