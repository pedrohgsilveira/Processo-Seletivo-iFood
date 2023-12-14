import Foundation
import XCTest
import CoreCoordinatorPub

@testable import CoreCoordinatorImp

final class CoordinatorTransitionTests: XCTestCase {
    fileprivate var sut: Transition<RootViewControllerSpy>!
    fileprivate var rootViewControllerSpy: RootViewControllerSpy!

    override func setUp() {
        super.setUp()
        rootViewControllerSpy = RootViewControllerSpy()
        sut = ViewTransitionFactory<RootViewControllerSpy>.make(())
        sut.rootViewController = rootViewControllerSpy
    }

    override func tearDown() {
        sut = nil
        rootViewControllerSpy = nil
        super.tearDown()
    }

    func test_push_been_called() {
        sut.perform(.push(animated: true), with: UIViewController())

        XCTAssertTrue(rootViewControllerSpy.pushViewControllerCalled)
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
