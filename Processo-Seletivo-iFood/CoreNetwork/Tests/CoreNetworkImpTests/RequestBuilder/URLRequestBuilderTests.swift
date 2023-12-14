import Foundation
import XCTest
import CoreNetworkPub

@testable import CoreNetworkImp

final class URLRequestBuilderTests: XCTestCase {
    var sut: URLRequestBuilder!

    override func setUp() {
        super.setUp()
        sut = URLRequestBuilder()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_request_creation() {
        let request = sut.createRequest(request: HTTPRequestDummy())
        XCTAssertNotNil(request)
    }
}

struct HTTPRequestDummy: HTTPRequest {
    var urlComponents: URLComponents {
        guard let components = URLComponents(string: "www.example.org") else {
            return URLComponents()
        }
        return components
    }

    var method: HTTPMethod {
        .get
    }

    var headers: [String : String]? {
        ["SomeHeaderKey": "SomeHeaderValue"]
    }

    var body: HTTPBody? {
        return nil
    }

    var queryParameters: [String : String]? {
        ["SomeQueryKey": "SomeQueryValue"]
    }

    var path: [String]? {
        ["/SomePath"]
    }
}
