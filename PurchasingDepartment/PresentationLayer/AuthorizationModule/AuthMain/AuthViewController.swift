import UIKit

class AuthViewController: UIViewController {
    
    let context: AppContext
    
    init(context: AppContext) {
        self.context = context
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let customView = AuthView(delegate: self)
        view = customView
    }
    
    // MARK: - Private methods
    
    private func auth() {
        context.userService.authorize()
        (UIApplication.shared.delegate as? AppDelegate)?.appCoordinator?.start(true)
    }
}

extension AuthViewController: AuthViewDelegate {
    func authViewDidSelectSignIn(view: AuthView) {
        auth()
    }
}
