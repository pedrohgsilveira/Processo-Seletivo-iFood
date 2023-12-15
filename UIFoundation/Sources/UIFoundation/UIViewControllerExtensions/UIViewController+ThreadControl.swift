import UIKit

extension UIViewController {
    func doOnMain(handler: @escaping (() -> Void)) {
        if Thread.current.isMainThread {
            handler()
        } else {
            DispatchQueue.main.sync(execute: handler)
        }
    }
}
