import Combine
import Foundation
import Redux

final class RepositoryListInteractor: Interacting<
RepositoryListState,
RepositoryListViewModel,
RepositoryListPresenter,
RepositoryListEvent,
RepositoryListMutation
>, RepositoryListInteracting {
    let provider: RepositoryListProviderProtocol

    init(provider: RepositoryListProviderProtocol, presenter: RepositoryListPresenter) {
        self.provider = provider

        super.init(presenter: presenter)
    }

    override func mutation(
        state: RepositoryListState,
        event: RepositoryListEvent
    ) -> AnyPublisher<RepositoryListMutation, Never> {
        switch event {
        case .fetchRepositoryList:
            return handleFetchRepositoryList(state.currentPage)
        }
    }

    override func reduce(state: RepositoryListState, mutation: RepositoryListMutation) -> RepositoryListState {
        var currentState = state

        switch mutation {
        case .startLoading:
            currentState.screenState = .loading
        case .showError:
            currentState.screenState = .error
        case let .showRepositories(items):
            currentState.items.append(contentsOf: items)
            currentState.screenState = .idle
            currentState.currentPage += 1
        }

        return currentState
    }
}

extension RepositoryListInteractor {
    private func handleFetchRepositoryList(_ page: Int) -> AnyPublisher<RepositoryListMutation, Never> {
        let event = Future<RepositoryListMutation, Never> { promise in
            Task.init {
                do {
                    let response = try await self.provider.fetchRepositoryList(with: page)
                    let items = response.items

                    let mutation: RepositoryListMutation = .showRepositories(items)

                    promise(.success(mutation))
                } catch {
                    promise(.success(.showError))
                }
            }
        }

        return event.prepend(Just(.startLoading)).eraseToAnyPublisher()
    }
}
