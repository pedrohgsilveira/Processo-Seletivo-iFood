import Foundation

enum RepositoryListSectionItem: Hashable {
    case repositoryListItem(RepositoryListTableViewCell.ViewModel)

    func hash(into hasher: inout Hasher) {
        switch self {
        case let .repositoryListItem(viewModel):
            hasher.combine(viewModel.identifier)
        }
    }
}
