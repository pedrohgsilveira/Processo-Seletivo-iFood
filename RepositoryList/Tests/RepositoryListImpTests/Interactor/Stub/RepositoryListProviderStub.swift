@testable import RepositoryListImp

final class RepositoryListProviderStub: RepositoryListProviderProtocol {
    var shouldFail: Bool = false

    func fetchRepositoryList(with currentPage: Int) async throws -> RepositoryListImp.RepositoryItemList {
        if shouldFail {
            throw RepositoryListProviderStubError.default
        }

        return .dummy
    }
}

enum RepositoryListProviderStubError: Error {
  case `default`
}

extension RepositoryListImp.RepositoryItemList {
    static var dummy: RepositoryListImp.RepositoryItemList {
        RepositoryListImp.RepositoryItemList(items: [.dummy])
    }
}

extension RepositoryItem {
    static var dummy: RepositoryItem {
        RepositoryItem(
            name: "some_name",
            owner: RepositoryOwner(ownerName: "some_owner_name", ownerProfileAvatarPath: "www.example.org"),
            description: "some_description",
            stargazersCount: 220,
            forksCount: 120
        )
    }
}
