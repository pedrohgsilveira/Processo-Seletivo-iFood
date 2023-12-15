import UIFoundation
import UIKit

final class UserProfileView: LayoutView {
    @AutoLayout private var mainContainer: UIStackView

    @AutoLayout private var profileImageView: UIImageView

    @AutoLayoutWithInit private var userNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .blue
        label.numberOfLines = .zero
        label.textAlignment = .center

        return label
    }()

    override func buildViewHierarchy() {
        addSubview(mainContainer)

        mainContainer.addArrangedSubviews(profileImageView, userNameLabel)
    }

    override func setupConstraints() {
        mainContainer.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }

    override func setupAdditionalConfiguration() {
        profileImageView.contentMode = .scaleAspectFit

        mainContainer.axis = .vertical
        mainContainer.spacing = 2
    }
}

extension UserProfileView: ViewModelConfigurable {
    func configure(with viewModel: ViewModel) {
        profileImageView.image = viewModel.userImage
        userNameLabel.text = viewModel.userName
    }
}

extension UserProfileView {
    struct ViewModel: Hashable {
        let userImage: UIImage
        let userName: String
    }
}
