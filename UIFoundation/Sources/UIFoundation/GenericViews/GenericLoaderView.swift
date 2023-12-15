import UIKit
import SnapKit

final class GenericLoaderView: UIView {
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


    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }

    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GenericLoaderView: ViewCodable {
    func buildViewHierarchy() {
        addSubview(blurEffectView)
        blurEffectView.contentView.addSubview(activityIndicator)

    }

    func setupConstraints() {
        blurEffectView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }

        activityIndicator.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}
