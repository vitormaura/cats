import Foundation

struct DescriptionModel: Codable {
    let id: String
    let imageURL: String
    let breedName: String
    let origin: String
    let temperament: String
    let description: String
    var isFavourite: Bool
}
