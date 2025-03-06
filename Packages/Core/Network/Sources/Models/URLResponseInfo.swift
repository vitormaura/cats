import Foundation

struct URLResponseInfo {
    let url: URL?
    let data: Data?
    let response: URLResponse?
    let error: Error?

    init(url: URL? = nil,
         data: Data? = nil,
         response: URLResponse? = nil,
         error: Error? = nil)
    {
        self.url = url
        self.data = data
        self.response = response
        self.error = error
    }
}
