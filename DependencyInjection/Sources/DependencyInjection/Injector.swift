import Foundation
import Swinject

public final class Injector {
    public static var shared: Injector = Injector()

    private let container: Container = Container()

    private init() {}

    public func register<Service>(
        _ serviceType: Service.Type,
        factory: @escaping () -> Service
    ) {
        container.register(serviceType) { _ in factory() }
    }

    func resolve<Service>(_ serviceType: Service.Type) -> Service {
        guard let service = container.resolve(serviceType) else {
            preconditionFailure("You must register an instance before accessing it")
        }

        return service
    }
}
