import Foundation
import UIKit

open class LayoutView: UIView, ViewCodable {
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open func buildViewHierarchy() {}
    open func setupConstraints() {}
    open func setupAdditionalConfiguration() {}
}
