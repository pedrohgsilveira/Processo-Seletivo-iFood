public protocol StateAbstraction {
    associatedtype InputEvent
    associatedtype OutputAction

    mutating func handleEvent(event: InputEvent) -> OutputAction?
}
