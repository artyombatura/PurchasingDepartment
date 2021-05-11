import UIKit

class UserAccountViewController: BaseLoableViewController {
    enum ScreenState {
        case normal
        case editing
    }
    
    let context: AppContext
    
    var state: ScreenState = .normal {
        didSet {
            (view as? UserAccountView)?.updateState(state)
        }
    }
    
    init(context: AppContext) {
        self.context = context
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let customView = UserAccountView(delegate: self)
        if let user = context.userService.user {
            customView.update(with: user)
        }
        self.view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Actions
    
    @objc private func logoutAction() {
        context.userService.deauthorize()
        (UIApplication.shared.delegate as? AppDelegate)?.appCoordinator?.start(true)
    }
    
    @objc private func registrationAction() {
        let alertController = UIAlertController(title: "Регистрация менеджера", message: "Заполните все поля, создавая нового менеджера в системе", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Отмена",
                                         style: .cancel) { _ in
            alertController.dismiss(animated: true, completion: nil)
        }
        let saveAction = UIAlertAction(title: "Зарегистрироваь",
                                       style: .default) { _ in
            
            self.isLoading = true
            
            var login: String?
            var password: String?
            var name: String?
            var surname: String?
            var phone: String?
            var email: String?
            
            alertController.textFields?.forEach({ tf in
                if let identifier = tf.accessibilityIdentifier,
                   let text = tf.text {
                    switch identifier {
                    case "login":
                        login = text
                    case "password":
                        password = text
                    case "name":
                        name = text
                    case "surname":
                        surname = text
                    case "phone":
                        phone = text
                    case "email":
                        email = text
                    default:
                        break
                    }
                }
            })
            
            if let login = login,
               let password = password,
               let name = name,
               let surname = surname,
               let phone = phone,
               let email = email {
                
                self.context.userService.register(login: login,
                                             password: password,
                                             name: name,
                                             surname: surname,
                                             email: email,
                                             phone: phone) { [weak self] error in
                    if let _ = error {
                        self?.context.alertDispatcher.showInfoAlert(title: "Ошибка сети", message: nil, okAction: nil)
                        alertController.dismiss(animated: true, completion: nil)
                    } else {
                        alertController.dismiss(animated: true, completion: nil)
                    }
                    self?.isLoading = false
                }
            } else {
                self.context.alertDispatcher.showInfoAlert(title: "Ошибка", message: "Заполните все поля", okAction: nil)
                self.isLoading = false
            }
        }
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        
        alertController.addTextField { tf in
            tf.placeholder = "Введите логин"
            tf.accessibilityIdentifier = "login"
        }
        alertController.addTextField { tf in
            tf.placeholder = "Введите пароль"
            tf.isSecureTextEntry = true
            tf.accessibilityIdentifier = "password"
        }
        alertController.addTextField { tf in
            tf.placeholder = "Введите имя"
            tf.accessibilityIdentifier = "name"
        }
        alertController.addTextField { tf in
            tf.placeholder = "Введите фамилию"
            tf.accessibilityIdentifier = "surname"
        }
        alertController.addTextField { tf in
            tf.placeholder = "Введите телефон"
            tf.accessibilityIdentifier = "phone"
        }
        alertController.addTextField { tf in
            tf.placeholder = "Введите email"
            tf.accessibilityIdentifier = "email"
        }
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Private methods
    
    private func configure() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.logoutButtonIcon,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(logoutAction))
        if let user = context.userService.user,
           user.role == true {
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                               target: self,
                                                               action: #selector(registrationAction))
        }
    }
}

extension UserAccountViewController: UserAccountViewDelegate {
    func userAccountViewDidSelectEdit() {
        state = .editing
    }
    
    func userrAccountViewDidSelectStopEdit() {
        state = .normal
    }
    
    func userAccountViewDidSelectSave() {
        state = .normal
    }
}
