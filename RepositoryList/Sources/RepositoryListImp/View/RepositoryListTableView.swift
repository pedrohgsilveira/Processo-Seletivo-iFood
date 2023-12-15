import UIFoundation
import UIKit

final class RepositoryListTableView: EndlessScrollTableView<RepositoryListSectionAdapter, RepositoryListViewModel> {
    override func registerCells() {
        register(RepositoryListTableViewCell.self, forCellReuseIdentifier: RepositoryListTableViewCell.identifier)
    }

    override func configureTableViewCell(
        _ tableView: UITableView,
        at indexPath: IndexPath,
        item: RepositoryListSectionItem
    ) -> UITableViewCell {
        switch item {
        case .repositoryListItem(let viewModel):
            guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: RepositoryListTableViewCell.identifier,
                    for: indexPath
            ) as? RepositoryListTableViewCell else {
                preconditionFailure("Cell must be registered")
            }

            cell.configure(with: viewModel)

            return cell
        }
    }
}
