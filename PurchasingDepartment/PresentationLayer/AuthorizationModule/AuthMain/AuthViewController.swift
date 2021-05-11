import UIKit

class AuthViewController: BaseLoableViewController {
    
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
    
    private func auth(with user: User) {
        context.userService.authorize(with: user)
        (UIApplication.shared.delegate as? AppDelegate)?.appCoordinator?.start(true)
    }
}

extension AuthViewController: AuthViewDelegate {
    func authViewDidSelectSignIn(view: AuthView, login: String, password: String) {
        isLoading = true
        context.userService.authRequest(login: login, password: password) { [weak self] response in
            switch response {
            case let .success(user):
                guard let user = user else {
                    self?.context.alertDispatcher.showInfoAlert(title: "Ошибка сети", message: nil, okAction: nil)
                    return
                }
                self?.auth(with: user)
                self?.isLoading = false
            case let .failure(_):
                self?.context.alertDispatcher.showInfoAlert(title: "Ошибка сети", message: nil, okAction: {
                    self?.isLoading = false
                })
            }
        }
    }
}
