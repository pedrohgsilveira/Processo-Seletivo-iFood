import Foundation
import XCTest
import CoreCoordinatorPub

@testable import CoreCoordinatorImp

final class CoordinatorStateTests: XCTestCase {
    var sut: CoordinatorState!

    override func setUp() {
        super.setUp()
        sut = .initialState
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_state_initial_state() {
        XCTAssertTrue(sut.registeredEvents.isEmpty)
    }
}
