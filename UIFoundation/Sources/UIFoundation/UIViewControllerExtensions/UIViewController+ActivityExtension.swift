import UIKit

extension UIViewController {
    enum AssociatedKey {
        static var loader: UInt8 = 0
    }

    private(set) var genericLoader: GenericLoaderView? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.loader) as? GenericLoaderView
        }

        set {
            objc_setAssociatedObject(self, &AssociatedKey.loader, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }

    public func startLoading() {
        stopLoading()

        doOnMain {
            let genericLoader = GenericLoaderView()
            self.genericLoader = genericLoader
            self.view.addSubview(genericLoader)
            genericLoader.snp.makeConstraints { make in
                make.top.leading.trailing.bottom.equalToSuperview()
            }
        }
    }

    public func stopLoading() {
        doOnMain {
            guard let genericLoader = self.genericLoader else { return }
            genericLoader.activityIndicator.stopAnimating()
            genericLoader.removeFromSuperview()
            self.genericLoader = nil
        }
    }
}
