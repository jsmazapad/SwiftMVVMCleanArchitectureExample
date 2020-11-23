import Foundation
import UIKit
extension UIRefreshControl {
    func refreshManually() {
        if let scrollView = superview as? UIScrollView {
            scrollView.setContentOffset(CGPoint(x: 0, y: scrollView.contentOffset.y - frame.height), animated: false)
        }
        beginRefreshing()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2, execute: {
          self.sendActions(for: .valueChanged)
        })
    }
}
