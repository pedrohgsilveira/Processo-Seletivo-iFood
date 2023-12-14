import CoreCoordinatorPub

public extension CoordinatorEvent {
    var key: CoordinatorEventType { return CoordinatorEventType(type(of: self)) }
    static var key: CoordinatorEventType { return CoordinatorEventType(self) }
}
