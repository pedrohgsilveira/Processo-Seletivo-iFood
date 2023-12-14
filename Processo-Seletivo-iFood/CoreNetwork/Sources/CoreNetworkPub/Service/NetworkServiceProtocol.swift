import Foundation

public protocol NetworkServiceProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: NetworkServiceProtocol {}
