import CoreNetworkPub
import Foundation

public struct URLRequestBuilder: URLRequestBuilderProtocol {
    private func getHttpMethod(from request: HTTPRequest) -> HTTPMethod {
        request.method
    }

    private func getHeaders(from request: HTTPRequest) -> [String: String]? {
        request.headers
    }

    private func getBodyData(from request: HTTPRequest) -> Data? {
        guard let body = request.body else { return nil }

        switch body {
        case .json(let data):
            return try? JSONBody(data).getData()
        }
    }

    private func getQueryParameters(from request: HTTPRequest) -> [String: String]? {
        request.queryParameters
    }

    private func getPath(from request: HTTPRequest) -> [String]? {
        request.path
    }

    private func createRequest(from request: HTTPRequest, url: URL, method: HTTPMethod) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        return request
    }

    public func createRequest(request: HTTPRequest) -> URLRequest? {
        var urlComponents = request.urlComponents

        if let path = getPath(from: request) {
            urlComponents.path = path.joined(separator: "/")
        }

        if let queryParameters = getQueryParameters(from: request) {
            urlComponents.queryItems = queryParameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        }

        guard let url = urlComponents.url else {
            return nil
        }

        var urlRequest = createRequest(from: request, url: url, method: getHttpMethod(from: request))

        if let headers = getHeaders(from: request) {
            headers.forEach {
                urlRequest.addValue($0.value, forHTTPHeaderField: $0.key)
            }
        }

        urlRequest.httpBody = getBodyData(from: request)

        return urlRequest
    }

    public init() {}
}
