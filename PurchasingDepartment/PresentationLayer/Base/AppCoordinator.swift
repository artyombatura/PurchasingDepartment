import UIKit

class AppCoordinator: TabsCoordinator {
    enum Flow {
        case auth
        case main
    }
    
    let window: UIWindow?
    
    var selectedFlow: Flow?
    
    private let tabBarController = MainTabsViewController()
    
    init(window: UIWindow?) {
        self.window = window
        super.init(root: tabBarController)
    }

    override func start(_ animated: Bool) {
        guard let flow = selectedFlow else {
            authFlow()
            return
        }
        switch flow {
        case .auth:
            authFlow()
        case .main:
            mainFlow()
        }
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
    
    private func authFlow() {
        let authCoordinator = AuthorizationCoordinator()
        window?.rootViewController = authCoordinator.present()
        window?.makeKeyAndVisible()
    }
}
