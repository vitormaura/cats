import SwiftUI

enum HomeBuilder {
    static func createRoute(dependencies: Dependencies) -> UIViewController {
        let dataStore = HomeDataStore()
        let dataProvider = HomeDataProvider(network: dependencies.network, storage: dependencies.storage)
        let router = HomeRouter(router: dependencies.router)
        let viewModel = HomeViewModel(dataStore: dataStore, dataProvider: dataProvider, router: router)
        let view = HomeView(viewModel: viewModel)
        let viewController = HomeViewController(rootView: view)

        router.viewController = viewController
        return viewController
    }
}
