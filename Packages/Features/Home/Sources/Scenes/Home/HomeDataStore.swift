import Foundation
import Models

protocol HomeDataStoreProtocol {
    var currentPage: Int { get set }
    var totalPages: Int { get set }
    var limit: Int { get set }
    var lastLoadedWidget: (any WidgetModel)? { get set }
    var widgetsNoFilter: [any WidgetModel] { get set }
    var isSearching: Bool { get set }
    var breedData: [BreedModel] { get set }
    var favoriteBreeds: [BreedModel] { get set }

    func resetValues()
}

final class HomeDataStore: HomeDataStoreProtocol {
    var currentPage: Int = 0
    var totalPages: Int = 6
    var limit: Int = 10
    var lastLoadedWidget: (any WidgetModel)?
    var widgetsNoFilter: [any WidgetModel] = []
    var isSearching: Bool = false
    var breedData: [BreedModel] = []
    var favoriteBreeds: [BreedModel] = []

    func resetValues() {
        currentPage = 0
        isSearching = false
        lastLoadedWidget = nil
        widgetsNoFilter = []
        breedData = []
    }
}
