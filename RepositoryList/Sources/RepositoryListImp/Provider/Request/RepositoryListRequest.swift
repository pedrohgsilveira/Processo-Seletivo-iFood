import CoreNetworkPub
import Foundation

enum RepositoryListRequest: HTTPRequest {
    case fetchRepositoryList(currentPage: Int)
}

extension RepositoryListRequest {
    private enum Constants {
        static var baseURL: String = "https://api.github.com"
    }

    var urlComponents: URLComponents {
        switch self {
        default:
            guard let components = URLComponents(string: Constants.baseURL) else {
                return URLComponents()
            }
            return components
        }
    }

    var method: HTTPMethod {
        switch self {
        case .fetchRepositoryList:
            return .get
        }
    }

    var headers: [String : String]? {
        switch self {
        case .fetchRepositoryList:
            return nil
        }
    }

    var body: HTTPBody? {
        switch self {
        case .fetchRepositoryList:
            return nil
        }
    }

    var queryParameters: [String : String]? {
        switch self {
        case .fetchRepositoryList(let currentPage):
            return ["q": "language: Swift", "sort": "stars", "page": "\(currentPage)"]
        }
    }

    var path: [String]? {
        switch self {
        case .fetchRepositoryList:
            return ["/search", "repositories"]
        }
    }
}
