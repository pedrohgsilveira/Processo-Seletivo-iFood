import Foundation
import UIKit
import Redux

struct RepositoryListViewModel: Equatable {
    let items: [RepositoryListTableViewCell.ViewModel]
    let screenState: RepositoryListScreenState
}

extension RepositoryListViewModel: ViewModelAbstraction {
    init(from state: RepositoryListState) {
        self.items = state.items.map { RepositoryListTableViewCell.ViewModel(from: $0) }
        self.screenState = state.screenState
    }
}

extension RepositoryListTableViewCell.ViewModel {
    init(from item: RepositoryItem) {
        self.init(
            repositoryName: item.name,
            repositoryDescription: item.description,
            forkScore: String(item.forksCount),
            starScore: String(item.stargazersCount),
            profileViewModel: UserProfileView.ViewModel(from: item.owner)
        )
    }
}

extension UserProfileView.ViewModel {
    init(from owner: RepositoryOwner) {
        self.init(userImage: UIImage(), userName: owner.ownerName)
    }
}
