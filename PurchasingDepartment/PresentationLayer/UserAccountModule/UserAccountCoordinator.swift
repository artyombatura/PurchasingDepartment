import UIKit

class UserAccountCoordinator: NavigationCoordinator, TabPresentable {
    let navigationController = BaseNavigationVC()
    
    var presentableTabBarItem: UITabBarItem {
        return .accountTab
    }
    
    func present() -> UIViewController {
        return navigationController
    }
    
    init() {
        super.init(root: navigationController)
        let accountVC = UserAccountViewController()
        accountVC.title = "Аккаунт"
        push(accountVC, animated: true)
    }
    
    override init(coordinator: NavigationCoordinator) {
        super.init(coordinator: coordinator)
    }
}
