import Combine
import Foundation

open class Interacting<State, ViewModel, Presenter, Event, Mutation>
where
State: StateAbstraction,
ViewModel: ViewModelAbstraction,
ViewModel.State == State,
Presenter: Presenting<State, ViewModel> {
    private var presenter: Presenter
    private var currentState: State = State.initialState()

    private var cancellables: Set<AnyCancellable> = []

    public init(presenter: Presenter) {
        self.presenter = presenter
    }

    public func execute(event: Event) {
        mutation(state: currentState, event: event)
            .receive(on: RunLoop.main)
            .sink { [weak self] mutation in
                guard let self else { return }

                let newState = self.reduce(state: self.currentState, mutation: mutation)

                self.currentState = newState
                print(newState)
                self.presenter.input = newState
            }.store(in: &cancellables)
    }

    open func reduce(state: State, mutation: Mutation) -> State {
        preconditionFailure("This method must be overrided")
    }

    open func mutation(state: State, event: Event) -> AnyPublisher<Mutation, Never> {
        preconditionFailure("This method must be overrided")
    }
}
