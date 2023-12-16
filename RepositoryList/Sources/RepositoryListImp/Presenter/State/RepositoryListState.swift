import UIFoundation
import Foundation
import Redux

struct RepositoryListState: StateAbstraction {
    var screenState: RepositoryListScreenState
    var items: [RepositoryItem]
    var currentPage: Int

    static func initialState() -> RepositoryListState {
        RepositoryListState(screenState: .idle, items: [], currentPage: 1)
    }
}

enum RepositoryListScreenState {
    case idle
    case loading
    case error
}
