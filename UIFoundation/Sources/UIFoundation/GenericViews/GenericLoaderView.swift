import SnapKit
import UIKit

final class GenericLoaderView: LayoutView {
    @AutoLayoutWithInit var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()

        return activityIndicator
    }()

    @AutoLayoutWithInit private var blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.8

        return blurEffectView
    }()

    override func buildViewHierarchy() {
        addSubview(blurEffectView)
        blurEffectView.contentView.addSubview(activityIndicator)

    }

    override func setupConstraints() {
        blurEffectView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }

        activityIndicator.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}
