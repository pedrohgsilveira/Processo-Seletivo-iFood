import UIKit

final class EndlessScrollTableViewDelegate: NSObject, UITableViewDelegate {
    private var didEndScroll: () -> Void

    init(
        didEndScroll: @escaping () -> Void
    ) {
        self.didEndScroll = didEndScroll

        super.init()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollViewHeight = scrollView.frame.size.height

        let contentYoffset = scrollView.contentOffset.y

        let distanceFromBottom = scrollView.contentSize.height - contentYoffset

        if distanceFromBottom <= scrollViewHeight {
            didEndScroll()
        }
    }
}
