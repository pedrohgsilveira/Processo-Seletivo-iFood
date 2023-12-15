import Foundation

public protocol ViewModelAbstraction {
    associatedtype State

    init(from state: State)
}
