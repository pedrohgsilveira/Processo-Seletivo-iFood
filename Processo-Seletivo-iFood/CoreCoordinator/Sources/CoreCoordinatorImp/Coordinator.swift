import CoreCoordinatorPub
import UIKit

open class Coordinator<RootViewController>: CoordinatorProtocol where RootViewController: RootViewControllerProtocol {
    public weak var rootViewController: RootViewController? {
        didSet {
            viewTransition.rootViewController = rootViewController
        }
    }

    public let parentCoordinator: CoordinatorProtocol?

    public private(set) var state: CoordinatorStateType

    private(set) var viewTransition: Transition<RootViewController>

    public init(
        viewTransition: Transition<RootViewController> = ViewTransitionFactory<RootViewController>.make(()),
        parentCoordinator: CoordinatorProtocol? = nil,
        initialState: CoordinatorStateType = CoordinatorState.initialState
    ) {
        self.viewTransition = viewTransition
        self.parentCoordinator = parentCoordinator
        self.state = initialState
    }

    public func register<Event>(for eventType: Event.Type, handler: @escaping (Event) -> UIViewController?) where Event: CoordinatorEvent {
        state.registeredEvents[eventType.key] = { event in
            guard let event = event as? Event else { return nil }
            return handler(event)
        }
    }
}

extension Coordinator {
    public func execute(_ event: CoordinatorEvent) {
        doOnMain { [weak self] in
            self?.handle(event)
        }
    }
}

extension Coordinator {
    private func doOnMain(handler: @escaping (() -> Void)) {
        if Thread.current.isMainThread {
            handler()
        } else {
            DispatchQueue.main.sync(execute: handler)
        }
    }

    private func handleWithParentCoordinator(_ event: CoordinatorEvent) {
        parentCoordinator?.execute(event)
    }

    private func handle(_ event: CoordinatorEvent) {
        guard let handler = state.registeredEvents[event.key] else {
            return handleWithParentCoordinator(event)
        }

        viewTransition.perform(event.associatedAction, with: handler(event))
    }
}
