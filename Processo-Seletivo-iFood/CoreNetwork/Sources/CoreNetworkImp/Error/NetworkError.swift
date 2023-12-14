import CoreNetworkPub
import Foundation

struct NetworkError: RequestError {
    let statusCode: StatusCode
    let type: NetworkErrorType

    var description: String {
        type.description
    }

    var errorDescription: String? { description }

    init(statusCode: Int, type: NetworkErrorType) {
        self.statusCode = StatusCode(rawValue: statusCode)
        self.type = type
    }

    init(statusCode: Int) {
        self.statusCode = StatusCode(rawValue: statusCode)
        self.type = NetworkErrorType(rawValue: StatusCode(rawValue: statusCode))
    }
}
