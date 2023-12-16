import CoreCoordinatorImp
import CoreCoordinatorPub
import CoreNetworkImp
import CoreNetworkPub
import DependencyInjection
import RepositoryListImp
import RepositoryListPub
import UIKit

public enum DependencyRegistering {
    public static func buildDependencyGraph() {
        registerCoordinator()
        registerNetworkClient()
        registerRequestBuilder()
        registerRepositoryListFactory()
    }

    private static func registerCoordinator() {
        Injector.shared.register(CoordinatorProtocol.self) {
            Coordinator<UINavigationController>()
        }
    }

    private static func registerNetworkClient() {
        Injector.shared.register(NetworkClientProtocol.self) {
            NetworkClient()
        }
    }

    private static func registerRequestBuilder() {
        Injector.shared.register(URLRequestBuilderProtocol.self) {
            URLRequestBuilder()
        }
    }

    private static func registerRepositoryListFactory() {
        Injector.shared.register(RepositoryListFactoryProtocol.self) {
            RepositoryListImpFactory()
        }
    }
}

extension UINavigationController: RootViewControllerProtocol {}
