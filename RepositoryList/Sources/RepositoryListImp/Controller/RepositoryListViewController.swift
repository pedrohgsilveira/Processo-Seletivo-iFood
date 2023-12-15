import UIFoundation
import UIKit

final class RepositoryListViewController: UIViewController {
    private let interactor: RepositoryListInteractor

    private let mainView = RepositoryListTableView(
        didSelectRowHandler: { _ in },
        didEndScroll: { }
    )

    init(
        interactor: RepositoryListInteractor
    ) {
        self.interactor = interactor

        super.init(nibName: nil, bundle: nil)
    }

    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        interactor.execute(event: .fetchRepositoryList(page: 0))
    }
}

extension RepositoryListViewController: RepositoryListViewControllerProtocol {
    func configure(with viewModel: RepositoryListViewModel) {
        switch viewModel.screenState {
        case .idle:
            mainView.appendSections(from: viewModel)
            stopLoading()

        case .loading:
            startLoading()

        case .error:
            stopLoading()
            showErrorView { [weak self] in
                guard let self else { return }
                self.interactor.execute(event: .fetchRepositoryList(page: 0))
            }
        }
    }
}
