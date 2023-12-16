import SnapKit
import UIFoundation
import UIKit

final class RepositoryListTableViewCell: UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }

    @AutoLayoutWithInit private var repositoryNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .blue
        label.numberOfLines = 0

        return label
    }()

    @AutoLayoutWithInit private var repositoryDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 3

        return label
    }()

    @AutoLayout private var forkScoreView: ScoreItemView

    @AutoLayout private var starScoreView: ScoreItemView

    @AutoLayout private var profileView: UserProfileView

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupView()
    }

    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupCell(with viewModel: ViewModel) {

    }
}

extension RepositoryListTableViewCell: ViewCodable {
    func buildViewHierarchy() {
        contentView.addSubviews(
            repositoryNameLabel, repositoryDescriptionLabel,
            forkScoreView, starScoreView, profileView
        )
    }

    func setupConstraints() {
        repositoryNameLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(24)
            make.leading.equalTo(contentView.snp.leading).offset(16)
        }

        repositoryDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(repositoryNameLabel.snp.bottom).offset(4)
            make.width.equalTo(contentView.snp.width).multipliedBy(0.72)
            make.leading.equalTo(contentView.snp.leading).offset(16)
        }

        forkScoreView.snp.makeConstraints { make in
            make.top.equalTo(repositoryDescriptionLabel.snp.bottom).offset(4)
            make.leading.equalTo(contentView.snp.leading).offset(16)
            make.bottom.equalTo(contentView.snp.bottom).offset(-24)
        }

        starScoreView.snp.makeConstraints { make in
            make.top.equalTo(repositoryDescriptionLabel.snp.bottom).offset(4)
            make.leading.equalTo(forkScoreView.snp.trailing).offset(8)
            make.bottom.equalTo(contentView.snp.bottom).offset(-24)
        }

        profileView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(24)
            make.leading.equalTo(repositoryDescriptionLabel.snp.trailing).offset(12)
            make.trailing.equalTo(contentView.snp.trailing).offset(-16)
            make.bottom.equalTo(contentView.snp.bottom).offset(-24)
        }
    }

    func setupAdditionalConfiguration() {
        contentView.backgroundColor = .white
    }
}

extension RepositoryListTableViewCell: ViewModelConfigurable {
    func configure(with viewModel: ViewModel) {
        repositoryNameLabel.text = viewModel.repositoryName
        repositoryDescriptionLabel.text = viewModel.repositoryDescription

        forkScoreView.configure(with: viewModel.forkScoreViewModel)
        starScoreView.configure(with: viewModel.starScoreViewModel)

        profileView.configure(with: viewModel.profileViewModel)
    }
}

extension RepositoryListTableViewCell {
    struct ViewModel: Equatable {
        let identifier: UUID = UUID()

        let repositoryName: String
        let repositoryDescription: String
        let forkScoreViewModel: ScoreItemView.ViewModel
        let starScoreViewModel: ScoreItemView.ViewModel
        let profileViewModel: UserProfileView.ViewModel

        init(
            repositoryName: String,
            repositoryDescription: String,
            forkScore: String,
            starScore: String,
            profileViewModel: UserProfileView.ViewModel
        ) {
            self.repositoryName = repositoryName
            self.repositoryDescription = repositoryDescription
            self.forkScoreViewModel = ScoreItemView.ViewModel(type: .fork, score: forkScore)
            self.starScoreViewModel = ScoreItemView.ViewModel(type: .star, score: starScore)
            self.profileViewModel = profileViewModel
        }
    }
}
