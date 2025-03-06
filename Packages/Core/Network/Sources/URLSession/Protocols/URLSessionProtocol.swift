import Foundation

protocol URLSessionProtocol {
    func dataTask(with request: URLRequest,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol
    func getTasksWithCompletionHandler(_ completionHandler: @escaping ([URLSessionDataTaskProtocol]) -> Void)
    func invalidateAndCancel()
    @MainActor func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {
    func dataTask(with request: URLRequest,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        let urlDataTask: URLSessionDataTask = self.dataTask(with: request, completionHandler: completionHandler)
        return urlDataTask
    }

    func getTasksWithCompletionHandler(_ completionHandler: @escaping ([URLSessionDataTaskProtocol]) -> Void) {
        getTasksWithCompletionHandler { dataTask , _, _ in
            completionHandler(dataTask as [URLSessionDataTaskProtocol])
        }
    }

    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        try await withCheckedThrowingContinuation { continuation in
            let task: URLSessionDataTask = self.dataTask(with: request,
                                                         completionHandler: { data, response, error in
                guard let data = data, let response = response else {
                    let error = error ?? URLError(.badServerResponse)
                    return continuation.resume(throwing: error)
                }

                continuation.resume(returning: (data, response))
            })

            task.resume()
        }
    }
}
