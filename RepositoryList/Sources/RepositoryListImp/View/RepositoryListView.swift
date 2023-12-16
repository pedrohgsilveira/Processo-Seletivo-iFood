import UIFoundation
import UIKit

final class RepositoryListView: LayoutView {
    private let mainView = RepositoryListTableView(
        didSelectRowHandler: { _ in },
        didEndScroll: { }
    )

    override func buildViewHierarchy() {
        addSubview(mainView)
    }

    override func setupConstraints() {
        mainView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension RepositoryListView: ViewModelConfigurable {
    func configure(with viewModel: RepositoryListViewModel) {
        mainView.appendSections(from: viewModel)
    }
}
