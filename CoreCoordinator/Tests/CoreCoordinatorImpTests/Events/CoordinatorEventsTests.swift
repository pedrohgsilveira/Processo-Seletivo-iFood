import Foundation
import XCTest
import CoreCoordinatorPub

@testable import CoreCoordinatorImp

final class CoordinatorEventsTests: XCTestCase {
    var sut: CoordinatorEvent!

    override func setUp() {
        super.setUp()
        sut = CoordinatorEventFake.push
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_event_key() {
        XCTAssertEqual(sut.key, CoordinatorEventFake.key)
    }

    func test_event_key_hash_value() {
        XCTAssertEqual(sut.key.hashValue, CoordinatorEventFake.key.hashValue)
    }

    func test_event_associated_action() {
        XCTAssertEqual(sut.associatedAction, .push(animated: true))
    }
}

fileprivate enum CoordinatorEventFake: CoordinatorEvent {
    case push
}

extension CoordinatorEventFake {
    var associatedAction: CoordinatorAssociatedAction {
        switch self {
        case .push:
            return .push(animated: true)
        }
    }
}
