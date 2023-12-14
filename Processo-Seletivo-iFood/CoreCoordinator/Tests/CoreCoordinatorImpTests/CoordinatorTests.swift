import Foundation
import XCTest
import CoreCoordinatorPub

@testable import CoreCoordinatorImp

final class CoordinatorTests: XCTestCase {
    fileprivate var sut: Coordinator<RootViewControllerSpy>!
    fileprivate var rootViewControllerSpy: RootViewControllerSpy!
    fileprivate var coordinatorHandlerSpy: CoordinatorHandlerSpy!

    override func setUp() {
        super.setUp()
        coordinatorHandlerSpy = CoordinatorHandlerSpy()
        rootViewControllerSpy = RootViewControllerSpy()

        sut = Coordinator()
        sut.rootViewController = rootViewControllerSpy
        sut.register(for: CoordinatorEventFake.self) { event in self.coordinatorHandlerSpy.handle(event) }
    }

    override func tearDown() {
        sut = nil
        rootViewControllerSpy = nil
        coordinatorHandlerSpy = nil
        super.tearDown()
    }

    func test_coordinator_register_events_on_state() {
        XCTAssertEqual(sut.state.registeredEvents.count, 1)
    }

    func test_coordinator_root_view_controller_setup() {
        XCTAssertIdentical(sut.rootViewController, rootViewControllerSpy)
    }

    func test_coordinator_execute_method() {
        sut.execute(CoordinatorEventFake.push)

        XCTAssertEqual(coordinatorHandlerSpy.capturedEvent, CoordinatorEventFake.push)
    }
}

fileprivate final class RootViewControllerSpy: RootViewControllerProtocol {
    private(set) var presentCalled: Bool = false
    private(set) var pushViewControllerCalled: Bool = false
    private(set) var popViewControllerCalled: Bool = false
    private(set) var popToRootViewControllerCalled: Bool = false
    private(set) var dismissCalled: Bool = false

    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?) {
        presentCalled = true
    }

    func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushViewControllerCalled = true
    }

    func popViewController(animated: Bool) -> UIViewController? {
        popViewControllerCalled = true
        return nil
    }

    func popToRootViewController(animated: Bool) -> [UIViewController]? {
        popToRootViewControllerCalled = true
        return nil
    }

    func dismiss(animated flag: Bool, completion: (() -> Void)?) {
        dismissCalled = true
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


fileprivate final class CoordinatorHandlerSpy {
    private(set) var capturedEvent: CoordinatorEventFake?

    lazy var handle: (CoordinatorEventFake) -> UIViewController? = { event in
        self.capturedEvent = event
        return nil
    }
}
