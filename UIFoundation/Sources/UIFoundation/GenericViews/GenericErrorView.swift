import SnapKit
import UIKit

final class GenericErrorView: UIView {
    private let retryAction: () -> Void

    @AutoLayoutWithInit private var errorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textColor = .black
        label.text = "An error occurred"
        label.numberOfLines = 0
        label.textAlignment = .center

        return label
    }()

    @AutoLayoutWithInit private var retryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("retry here", for: .normal)

        return button
    }()

    init(retryAction: @escaping () -> Void, frame: CGRect = .zero) {
        self.retryAction = retryAction

        super.init(frame: frame)

        setupView()
    }

    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    @objc private func retryLabelHasBeenClicked() {
        removeFromSuperview()
        retryAction()
    }
}

extension GenericErrorView: ViewCodable {
    func buildViewHierarchy() {
        addSubview(errorLabel)
        addSubview(retryButton)
    }

    func setupConstraints() {
        errorLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }

        retryButton.snp.makeConstraints { make in
            make.top.equalTo(errorLabel.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
    }

    func setupAdditionalConfiguration() {
        backgroundColor = .white

        retryButton.addTarget(self, action: #selector(retryLabelHasBeenClicked), for: .touchUpInside)
    }
}
