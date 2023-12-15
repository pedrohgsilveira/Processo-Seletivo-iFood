import Foundation

enum RepositoryListMutation {
    case startLoading
    case showError
    case showRepositories([RepositoryItem])
}
