import CoreCoordinatorPub
import UIKit

public struct Transition<RootViewController: RootViewControllerProtocol> {
    public weak var rootViewController: RootViewController?

    private var perform: PerformClosure

    typealias PerformClosure = (
        _ rootViewController: RootViewController?,
        _ targetViewController: UIViewController?,
        _ action: CoordinatorAssociatedAction
    ) -> Void

    init(perform: @escaping PerformClosure) {
        self.perform = perform
    }

    public func perform(
        _ action: CoordinatorAssociatedAction,
        with targetViewController: UIViewController?
    ) {
        autoreleasepool {
            perform(rootViewController, targetViewController, action)
        }
    }
}
