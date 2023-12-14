import Foundation

struct JSONBody {
    private let encoder: () throws -> Data

    public init(_ value: Encodable, encoder: JSONEncoder = JSONEncoder()) {
        self.encoder = { try encoder.encode(value) }
    }

    public func getData() throws -> Data {
        try encoder()
    }
}
