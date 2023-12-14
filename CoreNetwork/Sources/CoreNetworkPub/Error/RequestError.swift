import Foundation

public protocol RequestError: LocalizedError {
    var description: String { get }
}
