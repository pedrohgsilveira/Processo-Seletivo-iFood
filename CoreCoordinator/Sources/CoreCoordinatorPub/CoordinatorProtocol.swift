import Foundation
import UIKit

public protocol CoordinatorProtocol: AnyObject {
    var parentCoordinator: CoordinatorProtocol? { get }

    func execute(_ event: CoordinatorEvent)
    func register<Event>(for eventType: Event.Type, handler: @escaping (Event) -> UIViewController?) where Event: CoordinatorEvent
}
