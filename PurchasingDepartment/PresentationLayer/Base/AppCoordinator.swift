import UIKit

class AppCoordinator: TabsCoordinator {
    let window: UIWindow?
    
    private let tabBarController = MainTabsViewController()
    
    init(window: UIWindow?) {
        self.window = window
        super.init(root: tabBarController)
    }

    override func start(_ animated: Bool) {
        mainFlow()
    }
    
    // MARK: - Private
    
    private func mainFlow() {
        let jobsRequestCoordinator = JobsRequestCoordinator()
        let suppliersCoordinator = SuppliersCoordinator()
        let goodsCoordinator = GoodsCoordinator()
        let accountCoordinator = UserAccountCoordinator()
        
        setTabs([jobsRequestCoordinator, suppliersCoordinator, goodsCoordinator, accountCoordinator], animated: true)
        window?.rootViewController = tabBarController
        
        window?.makeKeyAndVisible()
    }
}
