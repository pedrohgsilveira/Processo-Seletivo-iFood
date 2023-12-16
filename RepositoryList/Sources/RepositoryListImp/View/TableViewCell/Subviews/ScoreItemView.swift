import SnapKit
import UIFoundation
import UIKit

final class ScoreItemView: LayoutView {
    @AutoLayoutWithInit private var scoreTypeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.numberOfLines = 0

        return label
    }()

    @AutoLayoutWithInit private var scoreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.numberOfLines = 0

        return label
    }()

    override func buildViewHierarchy() {
        addSubviews(scoreTypeLabel, scoreLabel)
    }

    override func setupConstraints() {
        scoreTypeLabel.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(4)
            make.leading.bottom.equalToSuperview()
        }

        scoreLabel.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(4)
            make.trailing.bottom.equalToSuperview()
            make.leading.equalTo(scoreTypeLabel.snp.trailing).offset(2)
        }
    }
}

extension ScoreItemView: ViewModelConfigurable {
    func configure(with viewModel: ViewModel) {
        scoreTypeLabel.text = viewModel.type.value
        scoreLabel.text = viewModel.score
    }
}

extension ScoreItemView {
    struct ViewModel: Equatable {
        let type: ScoreItemType
        let score: String
    }
}

enum ScoreItemType: String, Equatable {
    case fork
    case star

    var value: String {
        switch self {
        case .fork:
            return "fork"
        case .star:
            return "star"
        }
    }
}
