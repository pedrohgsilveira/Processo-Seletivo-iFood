import CoreNetworkPub
import Foundation

struct RepositoryListProvider: RepositoryListProviderProtocol {
    private let client: NetworkClientProtocol
    private let requestBuilder: URLRequestBuilderProtocol

    init(client: NetworkClientProtocol, requestBuilder: URLRequestBuilderProtocol) {
        self.client = client
        self.requestBuilder = requestBuilder
    }

    func fetchRepositoryList(with currentPage: Int) async throws -> RepositoryItemList {
        let fetchRepositoryListRequest = requestBuilder.createRequest(
            request: RepositoryListRequest.fetchRepositoryList(currentPage: currentPage)
        )

        return try await client.request(urlRequest: fetchRepositoryListRequest, responseType: RepositoryItemList.self)
    }
}
