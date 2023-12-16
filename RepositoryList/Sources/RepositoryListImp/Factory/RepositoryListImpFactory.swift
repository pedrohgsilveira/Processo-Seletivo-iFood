import CoreNetworkPub
import DependencyInjection
import RepositoryListPub
import UIKit

public struct RepositoryListImpFactory: RepositoryListFactoryProtocol {
    public init() {}

    public func make() -> UIViewController {
        @Injected var client: NetworkClientProtocol
        @Injected var requestBuilder: URLRequestBuilderProtocol

        let provider = RepositoryListProvider(client: client, requestBuilder: requestBuilder)

        let presenter = RepositoryListPresenter()

        let interactor = RepositoryListInteractor(provider: provider, presenter: presenter)

        let viewController = RepositoryListViewController(interactor: interactor)

        presenter.viewController = viewController

        viewController.executeInitialRequest()

        return viewController
    }
}
