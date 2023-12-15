import Combine

open class Presenting<State, ViewModel>: ObservableObject
where
State: StateAbstraction,
ViewModel: ViewModelAbstraction,
ViewModel.State == State {
    @Published public var input: State = State.initialState()

    public var output: AnyPublisher<ViewModel, Never> {
        return $input.map { state in
            ViewModel(from: state)
        }.eraseToAnyPublisher()
    }

    public init() {}
}
