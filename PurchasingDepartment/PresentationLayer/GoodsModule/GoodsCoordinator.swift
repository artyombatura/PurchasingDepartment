import UIKit

class GoodsCoordinator: NavigationCoordinator, TabPresentable {
    let navigationController = BaseNavigationVC()
    
    var presentableTabBarItem: UITabBarItem {
        return .goodsTab
    }
    
    func present() -> UIViewController {
        return navigationController
    }
    
    init(context: AppContext) {
        super.init(context: context, root: navigationController)
        let goodsVC = GoodsViewController(context: context)
        goodsVC.title = "Справочник"
        push(goodsVC, animated: true)
    }
    
    override init(coordinator: NavigationCoordinator) {
        super.init(coordinator: coordinator)
    }
}
