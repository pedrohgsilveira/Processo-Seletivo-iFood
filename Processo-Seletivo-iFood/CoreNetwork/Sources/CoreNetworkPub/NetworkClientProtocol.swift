import Foundation
import UIKit

public protocol NetworkClientProtocol {
    func request<T: Decodable>(
        urlRequest: URLRequest?,
        responseType: T.Type
    ) async throws -> T
    func donwloadImage(urlRequest: URLRequest?) async throws -> UIImage
}
