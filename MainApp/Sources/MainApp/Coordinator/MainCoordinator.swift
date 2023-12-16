import CoreCoordinatorImp
import CoreCoordinatorPub
import UIKit

public final class MainCoordinator: Coordinator<UINavigationController> {
    private let handler: MainCoordinatorEventHandlerProtocol

    public init(handler: MainCoordinatorEventHandlerProtocol = MainCoordinatorEventHandler()) {
        self.handler = handler

        super.init()

        register(for: MainCoordinatorEvent.self) { [weak self] event in self?.handler.handle(event) }
    }
}
