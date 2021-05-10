import UIKit

class SupplierSubview: UIView {
    
    enum ViewState {
        case canBeRemoved
        case notSelected
        case selected(price: Double)
    }
    
    // MARK: - Subviews
    
    private lazy var containerView: UIView = {
        let v = UIView(frame: .zero)
        v.backgroundColor = .white
        return v
    }()
    
    private lazy var supplierNameTitleLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.app16Font
        return l
    }()
    
    private lazy var supplierEmailTitleLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.app14Font
        return l
    }()
    
    private lazy var removeButton: AccessoryButtonItem = {
        let a = AccessoryButtonItem()
        a.action = { [weak self] in
            guard let self = self else {
                return
            }
            self.removeAction?(self)
        }
        a.displayType = .remove
        a.availability = .active
        return a
    }()
    
    private lazy var viewStateInfoView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.appGrayColor
        v.isHidden = true
        return v
    }()
    
    private lazy var priceTitleLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.app14BoldFont
        l.isHidden = true
        return l
    }()
    
    // MARK: - Variables
    
    var supplier: Supplier
    var viewState: ViewState = .canBeRemoved {
        didSet {
            switch viewState {
            case .canBeRemoved:
                removeButton.isHidden = false
                viewStateInfoView.isHidden = true
                priceTitleLabel.isHidden = true
            case .notSelected:
                removeButton.isHidden = true
                viewStateInfoView.isHidden = false
                priceTitleLabel.isHidden = true
                viewStateInfoView.backgroundColor = UIColor.appGrayColor
            case let .selected(price):
                removeButton.isHidden = true
                viewStateInfoView.isHidden = false
                priceTitleLabel.isHidden = false
                viewStateInfoView.backgroundColor = UIColor.appDefaultColor
                priceTitleLabel.text = "\(String(price))р."
            }
        }
    }
    var tapAction: ((SupplierSubview) -> Void)?
    var removeAction: ((SupplierSubview) -> Void)?
    
    init(supplier: Supplier) {
        self.supplier = supplier
        super.init(frame: .zero)
        
        setupUI()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTap))
        self.addGestureRecognizer(tapGesture)
        
        update(for: supplier, viewState: viewState)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.backgroundColor = UIColor.clear.cgColor
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1.0)
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 4.0

        layer.cornerRadius = 14
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    @objc private func onTap() {
        tapAction?(self)
    }
    
    @objc private func onRemoveTap() {
        removeAction?(self)
    }
    
    // MARK: - Public methods
    
    public func update(for supplier: Supplier, viewState: SupplierSubview.ViewState) {
        self.viewState = viewState
        self.supplier = supplier
        
        supplierNameTitleLabel.text = supplier.name
        supplierEmailTitleLabel.text = supplier.email
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        addSubview(containerView)
        containerView.addSubview(supplierNameTitleLabel)
        containerView.addSubview(supplierEmailTitleLabel)
        containerView.addSubview(viewStateInfoView)
        containerView.addSubview(removeButton)
        containerView.addSubview(priceTitleLabel)
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        supplierNameTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(2)
            $0.leading.equalToSuperview().offset(6)
            $0.trailing.equalToSuperview().inset(6)
            $0.height.equalTo(14)
        }
        
        supplierEmailTitleLabel.snp.makeConstraints {
            $0.top.equalTo(supplierNameTitleLabel).offset(20)
            $0.leading.trailing.height.equalTo(supplierNameTitleLabel)
        }
        
        viewStateInfoView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(10)
            $0.height.width.equalTo(24)
            $0.centerY.equalToSuperview()
        }
        
        removeButton.snp.makeConstraints {
            $0.trailing.equalTo(viewStateInfoView)
            $0.height.width.equalTo(viewStateInfoView)
            $0.centerY.equalToSuperview()
        }
        
        priceTitleLabel.snp.makeConstraints {
            $0.trailing.equalTo(viewStateInfoView.snp.leading).inset(4)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(60)
        }
        
        viewStateInfoView.layer.cornerRadius = 12
        removeButton.layer.cornerRadius = 12
    }
}
