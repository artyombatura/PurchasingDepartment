import UIKit

class NavigationCoordinator: Coordinator {
    private let rootController: UINavigationController
    
    init(root controller: UINavigationController) {
        rootController = controller
        super.init(root: controller)
    }
    
    init(coordinator: NavigationCoordinator) {
        rootController = coordinator.rootController
        super.init(coordinator: coordinator)
    }
    
    func push(_ presentable: Presentable, animated: Bool, completion: (() -> Void)? = nil) {
        rootController.pushViewController(present(presentable), animated: animated)
    }
    
    func pop(animated: Bool, completion: (() -> Void)? = nil) {
        rootController.popViewController(animated: animated)
    }
    
    func popToRoot(animated: Bool, completion: (() -> Void)?) {
        rootController.popToRootViewController(animated: animated)
    }
}
