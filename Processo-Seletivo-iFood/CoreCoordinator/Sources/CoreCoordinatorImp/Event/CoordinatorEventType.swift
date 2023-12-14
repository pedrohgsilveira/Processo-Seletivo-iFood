import CoreCoordinatorPub

public final class CoordinatorEventType: Hashable {
    typealias CoordinatorType = CoordinatorEvent.Type

    private let wrappedValue: CoordinatorType

    init(_ type: CoordinatorType) {
        wrappedValue = type
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(wrappedValue).hashValue)
    }

    public static func == (lhs: CoordinatorEventType, rhs: CoordinatorEventType) -> Bool {
        return lhs.wrappedValue == rhs.wrappedValue
    }
}
