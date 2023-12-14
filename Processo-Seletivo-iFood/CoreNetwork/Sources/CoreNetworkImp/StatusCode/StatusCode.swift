import Foundation

enum StatusCode: Int {
    public typealias RawValue = Int

    case ok = 200
    case notModified = 304
    case validationFailed = 422
    case serviceUnavailable = 503
    case undefined

    init(rawValue: RawValue) {
        switch rawValue {
        case 200:
            self = .ok
        case 304:
            self = .notModified
        case 422:
            self = .validationFailed
        case 503:
            self = .serviceUnavailable
        default:
            self = .undefined
        }
    }
}
