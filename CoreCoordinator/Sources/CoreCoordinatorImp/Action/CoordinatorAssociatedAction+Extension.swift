import CoreCoordinatorPub

extension CoordinatorAssociatedAction: Equatable {
    public static func == (lhs: CoordinatorAssociatedAction, rhs: CoordinatorAssociatedAction) -> Bool {
        switch (lhs, rhs) {
        case (.present, .present):
            return true
        case (.push, .push):
            return true
        case (.pop, .pop):
            return true
        case (.popToRoot, .popToRoot):
            return true
        case (.dismiss, .dismiss):
            return true
        default:
            return false
        }
    }
}
