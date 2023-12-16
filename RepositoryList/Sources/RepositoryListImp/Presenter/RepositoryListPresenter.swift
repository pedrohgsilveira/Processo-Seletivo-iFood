import Combine
import Foundation
import Redux

final class RepositoryListPresenter: Presenting<RepositoryListState, RepositoryListViewModel>, RepositoryListPresenting {
    private var cancellables: Set<AnyCancellable> = []
    var viewController: RepositoryListViewControllerProtocol?

    override init() {
        super.init()

        output.sink { [weak self] viewModel in
            guard let self else { return }
            self.viewController?.configure(with: viewModel)
        }.store(in: &cancellables)
    }
}
