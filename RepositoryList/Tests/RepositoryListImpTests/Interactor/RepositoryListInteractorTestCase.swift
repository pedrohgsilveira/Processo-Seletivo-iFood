import Foundation
import XCTest

@testable import RepositoryListImp

final class RepositoryListInteractorTestCase: XCTestCase {
    fileprivate var sut: RepositoryListInteractor!

    fileprivate var repositoryListProviderStub: RepositoryListProviderStub!
    fileprivate var presenter: RepositoryListPresenter!

    override func setUp() {
        super.setUp()
        repositoryListProviderStub = RepositoryListProviderStub()
        presenter = RepositoryListPresenter()

        sut = RepositoryListInteractor(
            provider: repositoryListProviderStub,
            presenter: presenter
        )
    }

    override func tearDown() {
        sut = nil

        repositoryListProviderStub = nil
        presenter = nil

        super.tearDown()
    }

    func testWhenFetchRepositoryListEventIsExecuted() throws {
        let mutations = sut.mutation(
            state: .initialState(),
            event: .fetchRepositoryList
        )

        let expected = try awaitPublisherValues(mutations, count: 2)

        XCTAssertEqual(expected.count, 2)
        XCTAssertEqual(expected.first, .startLoading)
        XCTAssertEqual(expected.last, .showRepositories([.dummy]))
    }

    func testWhenFetchRepositoryListEventIsExecutedWithAnFailure() throws {
        repositoryListProviderStub.shouldFail = true

        let mutations = sut.mutation(
            state: .initialState(),
            event: .fetchRepositoryList
        )

        let expected = try awaitPublisherValues(mutations, count: 2)

        XCTAssertEqual(expected.count, 2)
        XCTAssertEqual(expected.first, .startLoading)
        XCTAssertEqual(expected.last, .showError)
    }
}
