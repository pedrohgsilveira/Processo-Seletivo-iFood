import CoreCoordinatorPub
import UIKit

public enum MainCoordinatorEvent: CoordinatorEvent {
    case openRepositoryList
}

extension MainCoordinatorEvent {
    public var associatedAction: CoordinatorAssociatedAction {
        switch self {
        case .openRepositoryList:
            return .push(animated: true)
        }
    }
}
