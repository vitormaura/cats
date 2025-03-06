import Foundation

protocol DescriptionDataStoreProtocol {
    var favourites: [DescriptionModel] { get set }
}

final class DescriptionDataStore: DescriptionDataStoreProtocol {
    var favourites: [DescriptionModel] = []
}
