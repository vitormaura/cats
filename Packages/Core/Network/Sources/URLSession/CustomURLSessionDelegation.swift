import Foundation
import NetworkProtocol

protocol CustomURLSessionDelegateProtocol: URLSessionTaskDelegate { }

public final class CustomURLSessionDelegation: NSObject, CustomURLSessionDelegateProtocol {
    public override init() {
        super.init()
    }

    public func urlSession(_ session: URLSession,
                           didReceive challenge: URLAuthenticationChallenge,
                           completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        completionHandler(.performDefaultHandling, nil)
    }
}
