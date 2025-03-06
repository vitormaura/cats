import SwiftUI

enum DescriptionBuilder {
    static func createRoute(content: DescriptionModel,
                            dependencies: Dependencies) -> UIViewController {
        let dataProvider = DescriptionDataProvider(storage: dependencies.storage)
        let dataStore = DescriptionDataStore()
        let viewModel = DescriptionViewModel(content: content,
                                             dataProvider: dataProvider,
                                             dataStore: dataStore)
        let view = DescriptionView(viewModel: viewModel)
        let viewController = DescriptionViewController(rootView: view)
        return viewController
    }
}
