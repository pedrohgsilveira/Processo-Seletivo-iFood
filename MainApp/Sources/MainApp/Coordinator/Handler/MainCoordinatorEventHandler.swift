import CoreCoordinatorPub
import DependencyInjection
import RepositoryListPub
import UIKit

public protocol MainCoordinatorEventHandlerProtocol {
    func handle(_ event: MainCoordinatorEvent) -> UIViewController
}

public struct MainCoordinatorEventHandler: MainCoordinatorEventHandlerProtocol {
    public init() {}

    public func handle(_ event: MainCoordinatorEvent) -> UIViewController {
        switch event {
        case .openRepositoryList:
            @Injected var repositoryListFactory: RepositoryListFactoryProtocol
            
            return repositoryListFactory.make()
        }
    }
}
