import Foundation

struct BreedResponse: Decodable {
    let id: String
    let name: String
    let origin: String
    let temperament: String
    let description: String
    let referenceImageID: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case origin
        case temperament
        case description
        case referenceImageID = "reference_image_id"
    }
}
