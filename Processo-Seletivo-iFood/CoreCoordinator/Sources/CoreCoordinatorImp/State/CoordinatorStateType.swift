import CoreCoordinatorPub
import UIKit

public protocol CoordinatorStateType {
    typealias EventStrategy = (CoordinatorEvent) -> UIViewController?

    var registeredEvents: [CoordinatorEventType: EventStrategy] { get set }
}

public struct CoordinatorState: CoordinatorStateType {
    public var registeredEvents: [CoordinatorEventType: EventStrategy]
}

public extension CoordinatorState {
    static var initialState: CoordinatorState {
        return CoordinatorState(registeredEvents: [:])
    }
}
