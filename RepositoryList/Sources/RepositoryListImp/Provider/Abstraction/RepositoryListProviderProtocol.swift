import Foundation

protocol RepositoryListProviderProtocol {
    func fetchRepositoryList(with currentPage: Int) async throws -> RepositoryItemList
}
