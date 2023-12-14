import CoreNetworkPub
import Foundation

enum NetworkErrorType: RequestError, Equatable {
    case badURL
    case notModified
    case validationFailed
    case serviceUnavailable
    case failedToDecode(decodeError: String)
    case undefined

    typealias RawValue = StatusCode

    init(rawValue: RawValue) {
        switch rawValue {
        case .notModified:
            self = .notModified
        case .validationFailed:
            self = .validationFailed
        case .serviceUnavailable:
            self = .serviceUnavailable
        default:
            self = .undefined
        }
    }
}

extension NetworkErrorType {
    var description: String {
        switch self {
        case .badURL:
            return NetworkErrorTypeStrings.badUrl.rawValue
        case .notModified:
            return NetworkErrorTypeStrings.notModified.rawValue
        case .validationFailed:
            return NetworkErrorTypeStrings.validationFailed.rawValue
        case .serviceUnavailable:
            return NetworkErrorTypeStrings.serviceUnavailable.rawValue
        case .failedToDecode(let decodeError):
            return decodeError
        case .undefined:
            return NetworkErrorTypeStrings.undefined.rawValue
        }
    }
}
