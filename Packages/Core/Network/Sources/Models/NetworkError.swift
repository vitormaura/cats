enum NetworkError: Error {
    case timeout
    case noInternetConnection
    case networkConnectionLost
    case internalError
    case unknown
    case generic
    case jsonDecodingFailed(Error)
}
