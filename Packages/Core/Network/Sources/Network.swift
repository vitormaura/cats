import Foundation
import NetworkProtocol

public final class Network: NetworkProtocol {
    public private(set) var defaultHeaders: [String: String]
    public let baseURL: URL
    private let urlRequestCreator: URLRequestCreatorProtocol
    private let session: URLSessionProtocol
    private weak var customURLSessionDelegate: CustomURLSessionDelegateProtocol?

    init(session: URLSessionProtocol = URLSession.shared,
         requestInfo: RequestInfo,
         urlRequestCreator: URLRequestCreatorProtocol) {
        self.session = session
        self.baseURL = requestInfo.baseURL
        self.defaultHeaders = requestInfo.defaultHeaders
        self.urlRequestCreator = urlRequestCreator
    }

    deinit {
        session.invalidateAndCancel()
    }

    func setup(customURLSessionDelegate: CustomURLSessionDelegateProtocol) {
        self.customURLSessionDelegate = customURLSessionDelegate
    }

    @MainActor public func send<R>(_ resource: R) async throws -> R.Value where R: RequestProtocol {
        return try await send(resource, failReason: NetworkError.unknown)
    }

    @MainActor private func send<R>(_ resource: R,
                                    failReason: Error) async throws -> R.Value where R: RequestProtocol {
        var urlResponseInfo: URLResponseInfo

        do {
            let urlRequest = try createURLRequest(resource: resource)
            let (data, response) = try await session.data(for: urlRequest)
            urlResponseInfo = URLResponseInfo(data: data, response: response)
        } catch {
            urlResponseInfo = URLResponseInfo(error: error)
        }

        return try await handleDataTask(in: resource, urlResponseInfo: urlResponseInfo)
    }

    @MainActor private func handleDataTask<R: RequestProtocol>(in resource: R,
                                                               urlResponseInfo: URLResponseInfo) throws -> R.Value {
        guard let data = urlResponseInfo.data else {
            throw NetworkError.generic
        }

        do {
            let value = try resource.serialize(data: data)
            return value
        } catch {
            print(error)
            throw NetworkError.jsonDecodingFailed(error)
        }
    }

    private func createURLRequest<R>(resource: R) throws -> URLRequest where R: RequestProtocol {
        try urlRequestCreator.createURLRequest(for: resource, defaultHeaders: defaultHeaders)
    }

    private func networkError(from error: Error?) -> NetworkError {
        guard let error = error as? URLError else {
            return .unknown
        }
        switch error.code {
        case .timedOut:
            return .timeout
        case .notConnectedToInternet:
            return .noInternetConnection
        case .networkConnectionLost:
            return .networkConnectionLost
        case .cancelled:
            return .unknown
        default:
            return .generic
        }
    }

    private func headerFields(from response: URLResponse?) -> [String: Any] {
        guard let httpResponse = response as? HTTPURLResponse else {
            return [:]
        }

        let tupleHeaders: [(String, Any)] = httpResponse.allHeaderFields.compactMap { key, value in
            guard let key = (key as? String) else {
                return nil
            }
            return (key, value)
        }

        return Dictionary(uniqueKeysWithValues: tupleHeaders)
    }

    public func cancel<R>(_ resource: R) where R: RequestProtocol {
        guard let urlRequest = try? urlRequestCreator.createURLRequest(for: resource,
                                                                       defaultHeaders: defaultHeaders) else {
            return
        }

        session.getTasksWithCompletionHandler { taskArray in
            for task in taskArray where task.currentRequest?.url?.absoluteString == urlRequest.url?.absoluteString {
                task.cancel()
            }
        }
    }

    public func add(defaultHeader header: String, value: String) {
        defaultHeaders[header] = value
    }

    public func remove(defaultHeader header: String) {
        defaultHeaders.removeValue(forKey: header)
    }

    public func set(defaultHeaders: [String: String]) {
        self.defaultHeaders = defaultHeaders
    }
}
