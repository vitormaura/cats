import Foundation

protocol BaseDataTask {
    var currentRequest: URLRequest? { get }
    func resume()
    func cancel()
}

protocol URLSessionDataTaskProtocol: BaseDataTask { }

extension URLSessionDataTask: URLSessionDataTaskProtocol { }
