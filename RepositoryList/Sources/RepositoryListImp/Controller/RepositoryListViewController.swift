import UIFoundation
import UIKit

final class RepositoryListViewController: UIViewController {
    private let interactor: RepositoryListInteractor
    private var canPerformFetchRepositoryListRequest: Bool = true

    private lazy var didEndScroll: () -> Void = { [weak self] in
        guard let self else { return }

        self.executeFetchRequestRepositoryListRequest()
    }

    private lazy var mainView = RepositoryListView(didEndScroll: didEndScroll)

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

    func executeFetchRequestRepositoryListRequest() {
        if canPerformFetchRepositoryListRequest {
            interactor.execute(event: .fetchRepositoryList)
            canPerformFetchRepositoryListRequest = false
        }
    }
}

extension RepositoryListViewController: RepositoryListViewControllerProtocol {
    func configure(with viewModel: RepositoryListViewModel) {
        switch viewModel.screenState {
        case .idle:
            canPerformFetchRepositoryListRequest = true
            mainView.configure(with: viewModel)
            stopLoading()

        case .loading:
            canPerformFetchRepositoryListRequest = false
            startLoading()

        case .error:
            canPerformFetchRepositoryListRequest = true
            stopLoading()
            showErrorView { [weak self] in
                guard let self else { return }
                self.interactor.execute(event: .fetchRepositoryList)
            }
        }
    }
}
