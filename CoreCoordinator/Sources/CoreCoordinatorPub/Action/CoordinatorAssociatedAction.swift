import UIKit

public enum CoordinatorAssociatedAction {
    case present(animated: Bool, style: UIModalPresentationStyle, completion: (() -> Void)?)
    case push(animated: Bool)
    case pop(animated: Bool)
    case popToRoot(animated: Bool)
    case dismiss(animated: Bool, completion: (() -> Void)?)
}
