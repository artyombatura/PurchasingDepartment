import UIKit

/// Protocol for view controllers that can be presented
public protocol Presentable {
    /**
         Function to get view controller that can be presented.

         - returns: This view controller.
     **/
    func present() -> UIViewController
}

/// Protocol for view controllers that  can be presented by clicking on presentable tab bar item
public protocol TabPresentable: Presentable {
    var presentableTabBarItem: UITabBarItem { get }
}

extension UIViewController: TabPresentable {
    public func present() -> UIViewController {
        return self
    }

    public var presentableTabBarItem: UITabBarItem {
        return tabBarItem
    }
}
