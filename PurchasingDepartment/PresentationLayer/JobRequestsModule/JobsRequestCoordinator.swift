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
        let statusesVC = StatusesViewController(coordinator: self)
        statusesVC.title = "Заказы"
        push(statusesVC, animated: true)
    }
    
    override init(coordinator: NavigationCoordinator) {
        super.init(coordinator: coordinator)
    }
    
    func showJobsList(for status: JobStatus) {
        let list = MyOrdersListViewController(jobStatus: status, context: context)
        push(list, animated: true)
    }
}
