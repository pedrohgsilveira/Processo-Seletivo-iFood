import UIKit

public protocol RootViewControllerProtocol: AnyObject {
    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?)
    func pushViewController(_ viewController: UIViewController, animated: Bool)
    func popViewController(animated: Bool) -> UIViewController?
    func popToRootViewController(animated: Bool) -> [UIViewController]?
    func dismiss(animated flag: Bool, completion: (() -> Void)?)
}
