import UIKit

class JobsRequestCoordinator: NavigationCoordinator, TabPresentable {
    let navigationController = BaseNavigationVC()
    
    var presentableTabBarItem: UITabBarItem {
        return .jobsTab
    }
    
    func present() -> UIViewController {
        return navigationController
    }
    
    init() {
        super.init(root: navigationController)
        let statusesVC = StatusesViewController()
        push(statusesVC, animated: true)
    }
    
    override init(coordinator: NavigationCoordinator) {
        super.init(coordinator: coordinator)
    }
}
