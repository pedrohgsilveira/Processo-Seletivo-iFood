import Foundation

public protocol URLRequestBuilderProtocol {
    func createRequest(request: HTTPRequest) -> URLRequest?
}
