import Foundation
import UIKit

@propertyWrapper public struct AutoLayout<T> where T: UIView {
    private let value: T = {
        let view = T(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    public init () {}

    public var wrappedValue: T {
        return value
    }
}

@propertyWrapper public struct AutoLayoutWithInit<T> where T: UIView {
    private let value: T

    public init(wrappedValue: T) {
        self.value = wrappedValue
        value.translatesAutoresizingMaskIntoConstraints = false
    }

    public var wrappedValue: T {
        return value
    }
}
