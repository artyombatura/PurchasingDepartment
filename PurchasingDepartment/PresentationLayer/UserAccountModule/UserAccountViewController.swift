import UIKit

class UserAccountViewController: UIViewController {
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
    
    // MARK: - Private methods
    
    private func configure() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.logoutButtonIcon,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(logoutAction))
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
