import UIKit
import SnapKit

protocol SupplierDetailsViewDelegate: AnyObject {
    func supplierDetailsViewDidSelectSave(view: SupplierDetailsView)
}

class SupplierDetailsView: BaseScrollableView {
    
    weak var delegate: SupplierDetailsViewDelegate?
    var viewState: SupplierDetailsViewController.ScreenState
    
    // MARK: - Subviews
    
    private lazy var contentView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        return v
    }()
    
    private lazy var nameTitleLabel: UILabel = {
        let l = UILabel()
        l.text = "Поставщик:"
        l.font = UIFont.app16BoldFont
        return l
    }()
    
    private lazy var nameTextField: UnderlinedStateableTextField = {
        let tf = UnderlinedStateableTextField()
        tf.placeholder = "Введите название поставщика"
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
        tf.placeholder = "Введите электронную почту"
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
        tf.placeholder = "Введите телефон поставщика"
        return tf
    }()
    
    private lazy var addressTitleLabel: UILabel = {
        let l = UILabel()
        l.text = "Адрес:"
        l.font = UIFont.app16BoldFont
        return l
    }()
    
    private lazy var addressTextField: UnderlinedStateableTextField = {
        let tf = UnderlinedStateableTextField()
        tf.placeholder = "Введите адрес поставщика"
        return tf
    }()
    
    private lazy var productsTitleLabel: UILabel = {
        let l = UILabel()
        l.text = "Номенклатура:"
        l.font = UIFont.app16BoldFont
        return l
    }()
    
    private lazy var productsStackView: UIStackView = {
        let sv = UIStackView()
        sv.alignment = .center
        sv.distribution = .equalSpacing
        sv.axis = .vertical
        sv.spacing = 10
        return sv
    }()
    
    private lazy var positiveButton: ActionButton = {
        let b = ActionButton()
        b.title = "Добавить"
        b.layer.cornerRadius = 25
        b.action = { [weak self] in
            guard let self = self else {
                return
            }
            self.delegate?.supplierDetailsViewDidSelectSave(view: self)
        }
        return b
    }()
    
    init(supplier: Supplier? = nil, delegate: SupplierDetailsViewDelegate, state: SupplierDetailsViewController.ScreenState) {
        self.delegate = delegate
        self.viewState = state
        super.init()
        setupUI()
        updateStateDisplaying()
        configure(for: supplier)
        self.backgroundColor = .white
        self.scrollView.backgroundColor = .white
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    // MARK: - Private methods
    
    private func setupUI() {
        addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.addSubview(nameTitleLabel)
        contentView.addSubview(nameTextField)
        contentView.addSubview(emailTitleLabel)
        contentView.addSubview(emailTextField)
        contentView.addSubview(phoneNumberTitleLabel)
        contentView.addSubview(phoneTextField)
        contentView.addSubview(addressTitleLabel)
        contentView.addSubview(addressTextField)
        contentView.addSubview(productsTitleLabel)
        contentView.addSubview(productsStackView)
        contentView.addSubview(positiveButton)

        
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

        emailTitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(nameTitleLabel)
            make.top.equalTo(nameTextField.snp.bottom).offset(verticalOffset)
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

        addressTitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(nameTitleLabel)
            make.top.equalTo(phoneTextField.snp.bottom).offset(verticalOffset)
            make.height.equalTo(titleHeight)
        }

        addressTextField.snp.makeConstraints { make in
            make.leading.trailing.equalTo(nameTitleLabel)
            make.top.equalTo(addressTitleLabel.snp.bottom).offset(modulesVerticalOffset)
            make.height.equalTo(tfHeight)
        }
        
        productsTitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(nameTitleLabel)
            make.top.equalTo(addressTextField.snp.bottom).offset(verticalOffset)
            make.height.equalTo(titleHeight)
        }
        
        productsStackView.snp.makeConstraints { make in
            make.top.equalTo(productsTitleLabel.snp.bottom).offset(modulesVerticalOffset)
            make.leading.trailing.equalTo(nameTitleLabel)
        }
        
        positiveButton.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(48)
            make.centerX.equalToSuperview()
            make.top.equalTo(productsStackView.snp.bottom).offset(40)
        }
        
        contentView.snp.makeConstraints {
            $0.top.bottom.equalTo(scrollView)
            $0.left.right.equalTo(scrollView)
            $0.width.equalTo(scrollView)
            $0.bottom.equalTo(positiveButton.snp.bottom).offset(40)
        }
    }
    
    private func updateStateDisplaying() {
        switch viewState {
        case .view:
            positiveButton.isHidden = true
            nameTextField.tfState = .notEditable
            emailTextField.tfState = .notEditable
            phoneTextField.tfState = .notEditable
            addressTextField.tfState = .notEditable
        case .create:
            positiveButton.isHidden = false
            nameTextField.tfState = .editable
            emailTextField.tfState = .editable
            phoneTextField.tfState = .editable
            addressTextField.tfState = .editable
        }
    }
    
    private func configure(for supplier: Supplier?) {
        guard let supplier = supplier else {
            return
        }
        nameTextField.text = supplier.name
        emailTextField.text = supplier.email
        phoneTextField.text = supplier.phone
        addressTextField.text = supplier.address
        
        switch viewState {
        case .view:
            if let products = supplier.products {
                products.forEach { product in
                    let productView = SupplierProductView(product: product)
                    productsStackView.addArrangedSubview(productView)
                    productView.snp.makeConstraints {
                        $0.leading.trailing.equalToSuperview()
                        $0.height.equalTo(50)
                    }
                }
            }
        case .create:
            break
        }
    }
}
