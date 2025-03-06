import SwiftUI

enum FavouritesBuilder {
    static func createRoute(dependencies: Dependencies) -> UIViewController {
        let dataProvider = FavouritesDataProvider(storage: dependencies.storage)
        let router = FavouritesRouter(router: dependencies.router)
        let viewModel = FavouritesViewModel(dataProvider: dataProvider, router: router)
        let view = FavouritesView(viewModel: viewModel)
        let viewController = FavouritesViewController(rootView: view)

        router.viewController = viewController
        return viewController
    }
}
