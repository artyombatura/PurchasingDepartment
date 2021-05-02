import UIKit

class AuthorizationCoordinator: NavigationCoordinator {
    let navigationController = BaseNavigationVC()
    
    func present() -> UIViewController {
        return navigationController
    }
    
    init() {
        super.init(root: navigationController)
        let authVC = AuthViewController()
        authVC.title = "Авторизация"
        push(authVC, animated: true)
    }
    
    override init(coordinator: NavigationCoordinator) {
        super.init(coordinator: coordinator)
    }
}
