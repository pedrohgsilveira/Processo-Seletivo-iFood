import Foundation
import XCTest
import CoreNetworkPub

@testable import CoreNetworkImp

final class NetworkClientTests: XCTestCase {
    var sut: NetworkClient!
    fileprivate var serviceStub: NetworkServiceStub!

    override func setUp() {
        super.setUp()
        serviceStub = NetworkServiceStub()
        sut = NetworkClient(service: serviceStub)
    }

    override func tearDown() {
        serviceStub = nil
        sut = nil
        super.tearDown()
    }

    func test_perform_request_without_error() async throws {
        let request = URLRequest(url: URL(string: "www.example.org")!)
        let response = try await sut.request(urlRequest: request, responseType: String.self)

        XCTAssertEqual(response, "expected")
    }

    func test_perform_request_with_error() async throws {
        serviceStub.shouldFail = true
        serviceStub.statusCode = StatusCode(rawValue: 503)

        let request = URLRequest(url: URL(string: "www.example.org")!)

        do {
            _ = try await sut.request(urlRequest: request, responseType: String.self)
            XCTFail()
        } catch(let error) {
            XCTAssertEqual(error.localizedDescription, "undefined error")
        }
    }
}

fileprivate final class NetworkServiceStub: NetworkServiceProtocol {
    var shouldFail: Bool = false
    var statusCode: StatusCode = .ok

    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if shouldFail {
            throw NetworkError(statusCode: 0, type: .undefined)
        }

        guard let urlPath = request.url else {
            throw NetworkError(statusCode: 0, type: .badURL)
        }

        let urlResponse = HTTPURLResponse(
            url: urlPath,
            statusCode: statusCode.rawValue,
            httpVersion: nil,
            headerFields: nil
        )

        switch statusCode {
        case .ok:
            let str = "expected"
            let encodedData = try JSONEncoder().encode(str)

            return (encodedData, urlResponse!)

        case .notModified:
            throw NetworkError(statusCode: 0, type: .notModified)

        case .serviceUnavailable:
            throw NetworkError(statusCode: 0, type: .serviceUnavailable)

        case .validationFailed:
            throw NetworkError(statusCode: 0, type: .validationFailed)

        case .undefined:
            throw NetworkError(statusCode: 0, type: .undefined)
        }
    }
}
