import UIKit

class AppCoordinator: TabsCoordinator {
    let window: UIWindow?
    
    var context: AppContext = AppContext()
    
    private let tabBarController = MainTabsViewController()
    
    init(window: UIWindow?) {
        self.window = window
        super.init(root: tabBarController)
    }

    override func start(_ animated: Bool) {
        context.userService.isAuthorized ? mainFlow() : authFlow()
    }
    
    // MARK: - Private
    
    private func mainFlow() {
        let jobsRequestCoordinator = JobsRequestCoordinator(context: context)
        let suppliersCoordinator = SuppliersCoordinator(context: context)
        let goodsCoordinator = GoodsCoordinator(context: context)
        let accountCoordinator = UserAccountCoordinator(context: context)
        
        setTabs([jobsRequestCoordinator, suppliersCoordinator, goodsCoordinator, accountCoordinator], animated: true)
        window?.rootViewController = tabBarController
        
        window?.makeKeyAndVisible()
    }
    
    private func authFlow() {
        let authCoordinator = AuthorizationCoordinator(context: context)
        window?.rootViewController = authCoordinator.present()
        window?.makeKeyAndVisible()
    }
}
