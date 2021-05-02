import UIKit

class AppCoordinator: TabsCoordinator {
    let window: UIWindow?
    
    private let tabBarController = MainTabsViewController()
    
    init(window: UIWindow?) {
        self.window = window
        super.init(root: tabBarController)
    }

    override func start(_ animated: Bool) {
        
    }
    
    // MARK: - Private
    
    private func mainFlow() {
        let jobsRequestCoordinator = JobsRequestCoordinator()
        setTabs([jobsRequestCoordinator], animated: true)
        window?.rootViewController = tabBarController
        
        window?.makeKeyAndVisible()
    }
}
