import Foundation
import NetworkProtocol

struct BreedRequest: RequestProtocol {
    struct QueryParams: Encodable {
        let limit: Int
        let page: Int
    }

    typealias Value = [BreedResponse]

    var method = Method.get
    var path: String = "v1/breeds"
    var parameterEncoder: ParameterEncoder?

    init(queryParams: QueryParams) {
        let parameters = queryParams.dictionary
        parameterEncoder = URLParameterEncoder(parameters: parameters)
    }
}
