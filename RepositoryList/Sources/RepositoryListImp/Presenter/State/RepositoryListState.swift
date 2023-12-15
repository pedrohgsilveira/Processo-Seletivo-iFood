import UIFoundation
import Foundation
import Redux

struct RepositoryListState: StateAbstraction {
    var screenState: RepositoryListScreenState
    var items: [RepositoryItem]

    static func initialState() -> RepositoryListState {
        RepositoryListState(screenState: .idle, items: [])
    }
}

enum RepositoryListScreenState {
    case idle
    case loading
    case error
}
