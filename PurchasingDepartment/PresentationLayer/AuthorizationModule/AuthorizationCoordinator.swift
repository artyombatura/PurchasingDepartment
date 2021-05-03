import UIKit

class AuthorizationCoordinator: NavigationCoordinator {
    let navigationController = BaseNavigationVC()
    
    func present() -> UIViewController {
        return navigationController
    }
    
    init(context: AppContext) {
        super.init(context: context, root: navigationController)
        let authVC = AuthViewController(context: context)
        authVC.title = "Авторизация"
        push(authVC, animated: true)
    }
    
    override init(coordinator: NavigationCoordinator) {
        super.init(coordinator: coordinator)
    }
}
