import UIKit

class AuthViewController: UIViewController {
    override func loadView() {
        let customView = AuthView(delegate: self)
        view = customView
    }
    
    // MARK: - Private methods
    
    private func callAnotherFlow() {
        (UIApplication.shared.delegate as? AppDelegate)?.appCoordinator?.selectedFlow = .main
        (UIApplication.shared.delegate as? AppDelegate)?.appCoordinator?.start(true)
    }
}

extension AuthViewController: AuthViewDelegate {
    func authViewDidSelectSignIn(view: AuthView) {
        callAnotherFlow()
    }
}
