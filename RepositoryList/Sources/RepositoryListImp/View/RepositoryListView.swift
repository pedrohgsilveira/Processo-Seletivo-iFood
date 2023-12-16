import UIFoundation
import UIKit

final class RepositoryListView: LayoutView {
    private let didEndScroll: () -> Void

    private lazy var mainView = RepositoryListTableView(didEndScroll: didEndScroll)

    init(didEndScroll: @escaping () -> Void) {
        self.didEndScroll = didEndScroll
        super.init(frame: .zero)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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
