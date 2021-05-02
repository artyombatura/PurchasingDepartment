import UIKit

class TabsCoordinator: Coordinator {
    private let rootController: UITabBarController

    init(root controller: UITabBarController) {
        rootController = controller
        super.init(root: controller)
    }

    init(coordinator: TabsCoordinator) {
        rootController = coordinator.rootController
        super.init(coordinator: coordinator)
    }

    // MARK: - Overrides

    override func dismiss(animated: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: animated) {
            self.setTabs([], animated: false, completion: completion)
        }
    }

    // MARK: -

    func setTabs(_ tabs: [TabPresentable], animated: Bool, completion: (() -> Void)? = nil) {
        let controllers: [UIViewController] = tabs.map { tab in
            let controller = present(tab)
            controller.tabBarItem = tab.presentableTabBarItem
            return controller
        }
        rootController.setViewControllers(controllers, animated: animated)
    }

    var selectedIndex: Int {
        get {
            return rootController.selectedIndex
        }
        set {
            rootController.selectedIndex = newValue
        }
    }
}
