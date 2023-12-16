import Combine
import Foundation
import XCTest

extension XCTestCase {
    func awaitPublisherValues<T: Publisher>(
        _ publisher: T,
        count: Int,
        timeout: TimeInterval = 10
    ) throws -> [T.Output] {
        var result: Result<[T.Output], Error>?
        let expectation = self.expectation(description: "Awaiting publisher")

        let cancellable = publisher
            .collect(count)
            .first()
            .sink(
            receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    result = .failure(error)
                case .finished:
                    break
                }

                expectation.fulfill()
            },
            receiveValue: { value in
                result = .success(value)
            }
        )

        waitForExpectations(timeout: timeout)
        cancellable.cancel()

        let unwrappedResult = try XCTUnwrap(result)

        return try unwrappedResult.get()
    }
}
