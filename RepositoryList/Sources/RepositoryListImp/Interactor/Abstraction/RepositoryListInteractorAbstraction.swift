import Foundation
import Redux

protocol RepositoryListInteracting: Interacting<
RepositoryListState,
RepositoryListViewModel,
RepositoryListPresenter,
RepositoryListEvent,
RepositoryListMutation
> {
    var provider: RepositoryListProviderProtocol { get }

    init(provider: RepositoryListProviderProtocol, presenter: RepositoryListPresenter)
}
