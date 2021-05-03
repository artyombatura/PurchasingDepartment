import UIKit
import SnapKit

protocol UserAccountViewDelegate: AnyObject {
    func userAccountViewDidSelectEdit()
    func userrAccountViewDidSelectStopEdit()
    func userAccountViewDidSelectSave()
}

class UserAccountView: BaseScrollableView {
    
    weak var delegate: UserAccountViewDelegate?
    var viewState: UserAccountViewController.ScreenState = .normal
    
    // MARK: - Subviews
    
    private lazy var contentView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        return v
    }()
    
    private lazy var nameTitleLabel: UILabel = {
        let l = UILabel()
        l.text = "Имя:"
        l.font = UIFont.app16BoldFont
        return l
    }()
    
    private lazy var nameTextField: UnderlinedStateableTextField = {
        let tf = UnderlinedStateableTextField()
        tf.tfState = .notEditable
        tf.placeholder = "Имя пользователя"
        return tf
    }()
    
    private lazy var surnameTitleLabel: UILabel = {
        let l = UILabel()
        l.text = "Фамилия:"
        l.font = UIFont.app16BoldFont
        return l
    }()
    
    private lazy var surnameTextField: UnderlinedStateableTextField = {
        let tf = UnderlinedStateableTextField()
        tf.tfState = .notEditable
        tf.placeholder = "Фамилия пользователя"
        return tf
    }()
    
    private lazy var emailTitleLabel: UILabel = {
        let l = UILabel()
        l.text = "Электронная почта:"
        l.font = UIFont.app16BoldFont
        return l
    }()
    
    private lazy var emailTextField: UnderlinedStateableTextField = {
        let tf = UnderlinedStateableTextField()
        tf.tfState = .notEditable
        tf.placeholder = "Почта пользователя"
        return tf
    }()
    
    private lazy var phoneNumberTitleLabel: UILabel = {
        let l = UILabel()
        l.text = "Телефон:"
        l.font = UIFont.app16BoldFont
        return l
    }()
    
    private lazy var phoneTextField: UnderlinedStateableTextField = {
        let tf = UnderlinedStateableTextField()
        tf.tfState = .notEditable
        tf.placeholder = "Телефон пользователя"
        return tf
    }()
    
    private lazy var positiveButton: ActionButton = {
        let b = ActionButton()
        b.title = "Редактировать"
        b.layer.cornerRadius = 25
        b.action = { [weak self] in
            switch self?.viewState {
            case .normal:
                self?.delegate?.userAccountViewDidSelectEdit()
            case .editing:
                self?.delegate?.userAccountViewDidSelectSave()
            default:
                return
            }
        }
        return b
    }()
    
    private lazy var negativeButton: UIButton = {
        let b = UIButton()
        b.setTitle("Отменить редактирование", for: .normal)
        b.addTarget(self, action: #selector(negativeButtonAction), for: .touchUpInside)
        b.backgroundColor = .clear
        b.setTitleColor(.red, for: .normal)
        b.titleLabel?.font = UIFont.app12Font
        b.isHidden = true
        return b
    }()
    
    init(delegate: UserAccountViewDelegate) {
        self.delegate = delegate
        super.init()
        setupUI()
        self.backgroundColor = .white
        self.scrollView.backgroundColor = .white
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    @objc private func negativeButtonAction() {
        delegate?.userrAccountViewDidSelectStopEdit()
    }
    
    // MARK: - Public methods
    
    public func updateState(_ state: UserAccountViewController.ScreenState) {
        viewState = state
        switch state {
        case .editing:
            nameTextField.tfState = .editable
            surnameTextField.tfState = .editable
            emailTextField.tfState = .editable
            phoneTextField.tfState = .editable
            negativeButton.isHidden = false
            positiveButton.title = "Сохранить"
        case .normal:
            nameTextField.tfState = .notEditable
            surnameTextField.tfState = .notEditable
            emailTextField.tfState = .notEditable
            phoneTextField.tfState = .notEditable
            negativeButton.isHidden = true
            positiveButton.title = "Редактировать"
        }
    }
    
    public func update(with user: User) {
        // MARK: - TODO
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.addSubview(nameTitleLabel)
        contentView.addSubview(nameTextField)
        contentView.addSubview(surnameTitleLabel)
        contentView.addSubview(surnameTextField)
        contentView.addSubview(emailTitleLabel)
        contentView.addSubview(emailTextField)
        contentView.addSubview(phoneNumberTitleLabel)
        contentView.addSubview(phoneTextField)
        contentView.addSubview(positiveButton)
        contentView.addSubview(negativeButton)
        
        let sideOffset: CGFloat = 20.0
        let modulesVerticalOffset: CGFloat = 3.0
        let verticalOffset: CGFloat = 14.0
        let titleHeight: CGFloat = 20.0
        let tfHeight: CGFloat = 40.0
        
        
        nameTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(sideOffset)
            make.trailing.equalToSuperview().inset(sideOffset)
            make.top.equalToSuperview().offset(verticalOffset)
            make.height.equalTo(titleHeight)
        }

        nameTextField.snp.makeConstraints { make in
            make.leading.trailing.equalTo(nameTitleLabel)
            make.top.equalTo(nameTitleLabel.snp.bottom).offset(modulesVerticalOffset)
            make.height.equalTo(tfHeight)
        }

        surnameTitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(nameTitleLabel)
            make.top.equalTo(nameTextField.snp.bottom).offset(verticalOffset)
            make.height.equalTo(titleHeight)
        }

        surnameTextField.snp.makeConstraints { make in
            make.leading.trailing.equalTo(nameTitleLabel)
            make.top.equalTo(surnameTitleLabel.snp.bottom).offset(modulesVerticalOffset)
            make.height.equalTo(tfHeight)
        }

        emailTitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(nameTitleLabel)
            make.top.equalTo(surnameTextField.snp.bottom).offset(verticalOffset)
            make.height.equalTo(titleHeight)
        }

        emailTextField.snp.makeConstraints { make in
            make.leading.trailing.equalTo(nameTitleLabel)
            make.top.equalTo(emailTitleLabel.snp.bottom).offset(modulesVerticalOffset)
            make.height.equalTo(tfHeight)
        }

        phoneNumberTitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(nameTitleLabel)
            make.top.equalTo(emailTextField.snp.bottom).offset(verticalOffset)
            make.height.equalTo(titleHeight)
        }

        phoneTextField.snp.makeConstraints { make in
            make.leading.trailing.equalTo(nameTitleLabel)
            make.top.equalTo(phoneNumberTitleLabel.snp.bottom).offset(modulesVerticalOffset)
            make.height.equalTo(tfHeight)
        }

        positiveButton.snp.makeConstraints { make in
            make.height.equalTo(45)
            make.width.equalTo(200)
            make.bottom.equalTo(self.snp.bottomMargin).inset(50)
            make.centerX.equalToSuperview()
        }

        negativeButton.snp.makeConstraints { make in
            make.top.equalTo(positiveButton.snp.bottom).offset(10)
            make.height.equalTo(20)
            make.width.equalTo(200)
            make.top.equalTo(positiveButton.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.top.bottom.equalTo(scrollView)
            $0.left.right.equalTo(scrollView)
            $0.width.equalTo(scrollView)
            $0.height.equalToSuperview()
        }
    }
}
