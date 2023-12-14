import Foundation
import XCTest
import CoreNetworkPub

@testable import CoreNetworkImp

final class NetworkErrorTests: XCTestCase {
    var sut: NetworkError!

    override func setUp() {
        super.setUp()
        sut = NetworkError(statusCode: 0, type: .badURL)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_error_status_code() {
        XCTAssertEqual(sut.statusCode.rawValue, 504)
    }

    func test_error_description() {
        XCTAssertEqual(sut.description, "Could not use URL as Response")
    }

    func test_error_type() {
        XCTAssertEqual(sut.type, .badURL)
    }
}
