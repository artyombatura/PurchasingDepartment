import UIKit

class JobsRequestCoordinator: NavigationCoordinator, TabPresentable {
    let navigationController = BaseNavigationVC()
    
    var presentableTabBarItem: UITabBarItem {
        return .jobsTab
    }
    
    func present() -> UIViewController {
        return navigationController
    }
    
    init(context: AppContext) {
        super.init(context: context, root: navigationController)
        let statusesVC = StatusesViewController()
        statusesVC.title = "Заказы"
        push(statusesVC, animated: true)
    }
    
    override init(coordinator: NavigationCoordinator) {
        super.init(coordinator: coordinator)
    }
}
