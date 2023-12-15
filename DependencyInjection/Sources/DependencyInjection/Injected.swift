import Foundation

@propertyWrapper public struct Injected<Service> {
    public init () {}

    public var wrappedValue: Service {
        return Injector.shared.resolve(Service.self)
    }
}
