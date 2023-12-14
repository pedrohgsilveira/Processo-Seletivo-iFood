import CoreCoordinatorPub
import UIKit

public enum ViewTransitionFactory<RootViewController> where RootViewController: RootViewControllerProtocol {
    public typealias ViewTransition = Transition<RootViewController>
    public typealias Parameters = Void
    public typealias ResponseType = ViewTransition

    public static func make(_ parameters: Parameters) -> ResponseType {
        return ViewTransition { rootViewController, targetViewController, action in
            switch action {
            case let .present(animated, style, completion):
                guard let target = targetViewController else { return }
                target.modalPresentationStyle = style
                rootViewController?.present(target, animated: animated, completion: completion)

            case let .push(animated):
                guard let target = targetViewController else { return }
                rootViewController?.pushViewController(target, animated: animated)

            case let .pop(animated):
                _ = rootViewController?.popViewController(animated: animated)

            case let .popToRoot(animated):
                _ = rootViewController?.popToRootViewController(animated: animated)

            case let .dismiss(animated, completion):
                _ = rootViewController?.dismiss(animated: animated, completion: completion)
            }
        }
    }
}
