import Foundation

public enum HTTPBody {
    case json(data: Encodable)
}
