import Foundation

enum RepositoryListMutation: Equatable {
    case startLoading
    case showError
    case showRepositories([RepositoryItem])
}
