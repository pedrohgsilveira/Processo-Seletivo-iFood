import UIKit

extension UIViewController {
    enum ErrorAssociatedKey {
        static var error: UInt8 = 1
    }

    private(set) var genericError: GenericErrorView? {
        get {
            return objc_getAssociatedObject(self, &ErrorAssociatedKey.error) as? GenericErrorView
        }

        set {
            objc_setAssociatedObject(self, &ErrorAssociatedKey.error, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }

    public func showErrorView(_ completion: @escaping (() -> Void)) {
        let errorAction: () -> Void = { [weak self] in
            completion()

            guard let self else { return }

            self.genericError?.removeFromSuperview()
            self.genericError = nil
        }

        doOnMain {
            let errorView = GenericErrorView(retryAction: errorAction)
            self.view.addSubview(errorView)
            self.genericError = errorView
            errorView.snp.makeConstraints { make in
                make.top.leading.trailing.bottom.equalToSuperview()
            }
        }
    }
}
