import UIKit

protocol SuppliersCoordinatorProtocol {
    func didSelect(supplier: Supplier)
    func didSelectCreateNewSupplier()
}

class SuppliersCoordinator: NavigationCoordinator, TabPresentable, SuppliersCoordinatorProtocol {
    let navigationController = BaseNavigationVC()
    
    var presentableTabBarItem: UITabBarItem {
        return .supplierTab
    }
    
    func present() -> UIViewController {
        return navigationController
    }
    
    init(context: AppContext) {
        super.init(context: context, root: navigationController)
        let suppliersVC = SuppliersViewController(context: context, coordinator: self)
        suppliersVC.title = "Поставщики"
        push(suppliersVC, animated: true)
    }
    
    override init(coordinator: NavigationCoordinator) {
        super.init(coordinator: coordinator)
    }
    
    // MARK: - Navigations
    
    func didSelect(supplier: Supplier) {
        let supplierDetailsVC = SupplierDetailsViewController(context: context, supplier: supplier, for: .view)
        push(supplierDetailsVC, animated: true)
    }
    
    func didSelectCreateNewSupplier() {
        let supplierDetailsVC = SupplierDetailsViewController(context: context, supplier: nil, for: .create)
        push(supplierDetailsVC, animated: true)
    }
}
