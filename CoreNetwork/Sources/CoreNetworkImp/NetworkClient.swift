import CoreNetworkPub
import Foundation
import UIKit

public struct NetworkClient: NetworkClientProtocol {
    private let service: NetworkServiceProtocol

    public init(service: NetworkServiceProtocol = URLSession.shared) {
        self.service = service
    }

    private func decode<T>(
        decodableType: T.Type,
        data: Data
    ) throws -> T where T : Decodable {
        do {
            let decodedData = try JSONDecoder().decode(decodableType.self, from: data)
            return decodedData
        } catch(let error) {
            throw NetworkError(
                statusCode: 0,
                type: .failedToDecode(decodeError: error.localizedDescription)
            )
        }
    }

    private func validateResponse<T>(
        by code: StatusCode,
        with data: Data,
        decodableType: T.Type
    ) throws -> T where T : Decodable {
        switch code {
        case .ok:
            return try decode(decodableType: decodableType, data: data)
        default:
            throw NetworkError(statusCode: code.rawValue)
        }
    }

    private func request<T>(
        _ request: URLRequest,
        decodableType: T.Type
    ) async throws -> T where T : Decodable {
        let (data, response) = try await service.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError(statusCode: 0, type: .badURL)
        }

        let statusCode = StatusCode(rawValue: httpResponse.statusCode)

        return try validateResponse(by: statusCode, with: data, decodableType: decodableType)
    }

    public func request<T>(
        urlRequest: URLRequest?,
        responseType: T.Type
    ) async throws -> T where T : Decodable {
        guard let urlRequest else {
            throw NetworkError(statusCode: 0, type: .badURL)
        }

        return try await request(urlRequest, decodableType: responseType)
    }

    private func donwloadImageData(_ request: URLRequest) async throws -> Data {
        let (data, response) = try await service.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError(statusCode: 0, type: .badURL)
        }

        let statusCode = StatusCode(rawValue: httpResponse.statusCode)

        switch statusCode {
        case .ok:
            return data
        default:
            throw NetworkError(statusCode: statusCode.rawValue)
        }
    }

    public func donwloadImage(urlRequest: URLRequest?) async throws -> UIImage {
        guard let urlRequest else {
            throw NetworkError(statusCode: 0, type: .badURL)
        }

        let data = try await donwloadImageData(urlRequest)

        guard let image = UIImage(data: data) else {
            throw NetworkError(
                statusCode: 0,
                type: .failedToDecode(decodeError: NetworkErrorTypeStrings.failedToDecodeImage.rawValue)
            )
        }

        return image
    }
}
