import Foundation
import NetworkProtocol

public enum NetworkBuilder {
    public static func create(with urlSession: URLSession? = nil,
                              requestInfo: RequestInfo,
                              urlRequestCreator: URLRequestCreatorProtocol? = nil) -> Network {
        let urlRequestCreator = urlRequestCreator ?? URLRequestCreator(baseURL: requestInfo.baseURL)
        let customDelegate = customURLSessionDelegate()
        let urlSession = urlSession ?? defaultUrlSession(customDelegate: customDelegate)
        let client = Network(session: urlSession,
                             requestInfo: requestInfo,
                             urlRequestCreator: urlRequestCreator)
        client.setup(customURLSessionDelegate: customDelegate)
        return client
    }

    private static func defaultUrlSession(customDelegate: CustomURLSessionDelegateProtocol) -> URLSession {
        let configuration = URLSessionConfiguration.default
        return URLSession(configuration: configuration,
                          delegate: customDelegate,
                          delegateQueue: nil)
    }

    private static func customURLSessionDelegate() -> CustomURLSessionDelegateProtocol {
        return CustomURLSessionDelegation()
    }
}
