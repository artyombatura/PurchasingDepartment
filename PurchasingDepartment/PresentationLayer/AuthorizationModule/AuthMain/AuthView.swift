import UIKit
import SnapKit

protocol AuthViewDelegate: AnyObject {
    func authViewDidSelectSignIn(view: AuthView)
}

class AuthView: UIView {
    
    weak var delegate: AuthViewDelegate?
    
    // MARK: - Subviews
    private lazy var loginTextField: UnderlinedTextField = {
        let tf = UnderlinedTextField()
        tf.placeholder = "Логин"
        return tf
    }()
    
    private lazy var passwordTextField: UnderlinedTextField = {
        let tf = UnderlinedTextField()
        tf.placeholder = "Пароль"
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private lazy var textFieldsStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [loginTextField, passwordTextField])
        sv.alignment = .center
        sv.distribution = .fillEqually
        sv.axis = .vertical
        return sv
    }()
    
    private lazy var authButton: ActionButton = {
        let b = ActionButton()
        b.backgroundColor = .black
        b.title = "Войти"
        b.action = { [weak self] in
            guard let self = self else {
                return
            }
            self.delegate?.authViewDidSelectSignIn(view: self)
        }
        b.layer.cornerRadius = 25
        return b
    }()
    
    init(delegate: AuthViewDelegate) {
        self.delegate = delegate
        super.init(frame: .zero)
        
        arrangeSubviews()
        setupUI()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Coder is not implemented")
    }
    
    // MARK: - Public methods
    
    
    // MARK: - Private methods
    
    private func arrangeSubviews() {
        addSubview(textFieldsStackView)
        addSubview(authButton)
    }
    
    private func setupUI() {
        loginTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
        }
        
        passwordTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
        }
    
        textFieldsStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(40)
            $0.trailing.equalToSuperview().inset(40)
            $0.height.equalTo(100)
            $0.centerY.equalToSuperview()
        }
        
        authButton.snp.makeConstraints {
            $0.width.equalTo(200)
            $0.height.equalTo(48)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(self.snp_bottomMargin).inset(40)
        }
    }
    
    private func configureUI() {
        self.backgroundColor = .white
    }
}
