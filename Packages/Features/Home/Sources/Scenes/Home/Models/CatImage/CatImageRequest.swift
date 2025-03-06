import Foundation
import NetworkProtocol

struct CatImageRequest: RequestProtocol {
    typealias Value = CatImageResponse
    var method = Method.get
    var parameterEncoder: ParameterEncoder? = nil
    var path: String

    init(id: String?) {
        path = "v1/images/\(id ?? "")"
    }
}
