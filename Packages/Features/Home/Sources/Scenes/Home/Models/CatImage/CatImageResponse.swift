import Foundation

struct CatImageResponse: Decodable {
    let id: String
    let url: String
    let breeds: [BreedResponse]
    let width: Int
    let height: Int

    enum CodingKeys: String, CodingKey {
        case id
        case url
        case breeds
        case width
        case height
    }
}
