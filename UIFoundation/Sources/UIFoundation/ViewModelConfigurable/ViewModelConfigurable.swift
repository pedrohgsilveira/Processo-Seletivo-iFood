import Foundation

public protocol ViewModelConfigurable {
    associatedtype ViewModel

    func configure(with viewModel: ViewModel)
}
