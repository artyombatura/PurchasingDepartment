import UIKit

class SuppliersCoordinator: NavigationCoordinator, TabPresentable {
    let navigationController = BaseNavigationVC()
    
    var presentableTabBarItem: UITabBarItem {
        return .supplierTab
    }
    
    func present() -> UIViewController {
        return navigationController
    }
    
    init(context: AppContext) {
        super.init(context: context, root: navigationController)
        let suppliersVC = SuppliersViewController()
        suppliersVC.title = "Поставщики"
        push(suppliersVC, animated: true)
    }
    
    override init(coordinator: NavigationCoordinator) {
        super.init(coordinator: coordinator)
    }
}
