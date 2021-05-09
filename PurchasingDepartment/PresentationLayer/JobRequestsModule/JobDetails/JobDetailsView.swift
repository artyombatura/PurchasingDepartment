import UIKit

class JobDetailsView: BaseScrollableView {
    private lazy var contentView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        return v
    }()
    
    private lazy var nameTitleLabel: UILabel = {
        let l = UILabel()
        l.text = "Наименование:"
        l.font = UIFont.app16BoldFont
        return l
    }()
    
    private lazy var nameTextField: UnderlinedStateableTextField = {
        let tf = UnderlinedStateableTextField()
        tf.text = order.name
        return tf
    }()
    
    private lazy var partNumberTitleLabel: UILabel = {
        let l = UILabel()
        l.text = "Артикул:"
        l.font = UIFont.app16BoldFont
        return l
    }()
    
    private lazy var partNumberTextField: UnderlinedStateableTextField = {
        let tf = UnderlinedStateableTextField()
        tf.text = order.partNumber
        return tf
    }()
    
    private lazy var noteTitleLabel: UILabel = {
        let l = UILabel()
        l.text = "Заметка:"
        l.font = UIFont.app16BoldFont
        return l
    }()
    
    private lazy var noteTextField: UnderlinedStateableTextField = {
        let tf = UnderlinedStateableTextField()
        tf.placeholder = "Добавьте заметку или оставьте поле пустым"
        return tf
    }()
    
    private lazy var countTitleLabel: UILabel = {
        let l = UILabel()
        l.text = "Количество:"
        l.font = UIFont.app16BoldFont
        return l
    }()
    
    private lazy var countTextField: UnderlinedStateableTextField = {
        let tf = UnderlinedStateableTextField()
        tf.text = String(order.numberOfItems)
        return tf
    }()
    
    private lazy var dateTitleLabel: UILabel = {
        let l = UILabel()
        l.text = "Дата:"
        l.font = UIFont.app16BoldFont
        return l
    }()
    
    private lazy var dateSelectionButttonStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.alignment = .center
        sv.distribution = .fillEqually
        sv.spacing = 10
        sv.addArrangedSubview(removeDateButton)
        sv.addArrangedSubview(addDateButton)
        return sv
    }()
    
    private lazy var addDateButton: AccessoryButtonItem = {
        let b = AccessoryButtonItem()
        b.displayType = .add
        b.action = { [weak self] in
            
        }
        return b
    }()
    
    private lazy var removeDateButton: AccessoryButtonItem = {
        let b = AccessoryButtonItem()
        b.displayType = .remove
        b.action = { [weak self] in
            
        }
        b.availability = .disabled
        return b
    }()
    
    private lazy var selectedDateLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.app16Font
        l.textColor = UIColor.appGrayColor
        l.text = "24.07.2021"
        return l
    }()
    
    private lazy var suppliersTitleLabel: UILabel = {
        let l = UILabel()
        l.text = "Поставщики:"
        l.font = UIFont.app16BoldFont
        return l
    }()
    
    private lazy var supplierSelectionButttonStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.alignment = .center
        sv.distribution = .fillEqually
        sv.spacing = 10
        sv.addArrangedSubview(removeSupplierButton)
        sv.addArrangedSubview(addSupplierButton)
        return sv
    }()
    
    private lazy var addSupplierButton: AccessoryButtonItem = {
        let b = AccessoryButtonItem()
        b.displayType = .add
        b.action = { [weak self] in
            
        }
        return b
    }()
    
    private lazy var removeSupplierButton: AccessoryButtonItem = {
        let b = AccessoryButtonItem()
        b.displayType = .remove
        b.action = { [weak self] in
            
        }
        b.availability = .disabled
        return b
    }()
    
    private lazy var suppliersStackView: UIStackView = {
        let sv = UIStackView()
        sv.alignment = .center
        sv.distribution = .equalSpacing
        sv.axis = .vertical
        return sv
    }()
    
    private lazy var positivieButton: ActionButton = {
        let b = ActionButton()
        b.setAction { [weak self] in
            self?.positiveButtonAction()
        }
        b.title = "Отправить"
        b.layer.cornerRadius = 25
        return b
    }()
    
    var order: Order
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.mm.YYYY"
        return formatter
    }()
    
    init(order: Order) {
        self.order = order
        super.init()
        self.backgroundColor = .white
        self.scrollView.backgroundColor = .white
        
        setupUI()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        contentView.addSubview(partNumberTitleLabel)
        contentView.addSubview(partNumberTextField)
        contentView.addSubview(noteTitleLabel)
        contentView.addSubview(noteTextField)
        contentView.addSubview(countTitleLabel)
        contentView.addSubview(countTextField)
        contentView.addSubview(dateTitleLabel)
        contentView.addSubview(dateSelectionButttonStackView)
        contentView.addSubview(selectedDateLabel)
        contentView.addSubview(suppliersTitleLabel)
        contentView.addSubview(supplierSelectionButttonStackView)
        contentView.addSubview(suppliersStackView)
        contentView.addSubview(positivieButton)
        
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

        partNumberTitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(nameTitleLabel)
            make.top.equalTo(nameTextField.snp.bottom).offset(verticalOffset)
            make.height.equalTo(titleHeight)
        }

        partNumberTextField.snp.makeConstraints { make in
            make.leading.trailing.equalTo(nameTitleLabel)
            make.top.equalTo(partNumberTitleLabel.snp.bottom).offset(modulesVerticalOffset)
            make.height.equalTo(tfHeight)
        }

        noteTitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(nameTitleLabel)
            make.top.equalTo(partNumberTextField.snp.bottom).offset(verticalOffset)
            make.height.equalTo(titleHeight)
        }

        noteTextField.snp.makeConstraints { make in
            make.leading.trailing.equalTo(nameTitleLabel)
            make.top.equalTo(noteTitleLabel.snp.bottom).offset(modulesVerticalOffset)
            make.height.equalTo(tfHeight)
        }

        countTitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(nameTitleLabel)
            make.top.equalTo(noteTextField.snp.bottom).offset(verticalOffset)
            make.height.equalTo(titleHeight)
        }

        countTextField.snp.makeConstraints { make in
            make.leading.trailing.equalTo(nameTitleLabel)
            make.top.equalTo(countTitleLabel.snp.bottom).offset(modulesVerticalOffset)
            make.height.equalTo(tfHeight)
        }
        
        dateTitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(nameTitleLabel)
            make.top.equalTo(countTextField.snp.bottom).offset(verticalOffset)
            make.height.equalTo(titleHeight)
        }
        
        dateSelectionButttonStackView.snp.makeConstraints { make in
            make.trailing.equalTo(nameTitleLabel)
            make.width.equalTo(58)
            make.height.equalTo(24)
            make.top.equalTo(dateTitleLabel)
        }
        
        addDateButton.snp.makeConstraints { make in
            make.width.height.equalTo(24)
        }

        removeDateButton.snp.makeConstraints { make in
            make.width.height.equalTo(24)
        }
        
        selectedDateLabel.snp.makeConstraints { make in
            make.top.equalTo(dateTitleLabel.snp.bottom).offset(modulesVerticalOffset)
            make.leading.trailing.equalTo(nameTitleLabel)
            make.height.equalTo(tfHeight)
        }
        
        suppliersTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(selectedDateLabel.snp.bottom).offset(verticalOffset)
            make.leading.trailing.equalTo(nameTitleLabel)
            make.height.equalTo(titleHeight)
        }
        
        supplierSelectionButttonStackView.snp.makeConstraints { make in
            make.trailing.equalTo(nameTitleLabel)
            make.width.equalTo(58)
            make.height.equalTo(24)
            make.top.equalTo(suppliersTitleLabel)
        }
        
        addSupplierButton.snp.makeConstraints { make in
            make.width.height.equalTo(24)
        }

        removeSupplierButton.snp.makeConstraints { make in
            make.width.height.equalTo(24)
        }
        
        suppliersStackView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(nameTitleLabel)
            make.top.equalTo(supplierSelectionButttonStackView.snp.bottom).offset(verticalOffset)
        }
        
        positivieButton.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(48)
            make.centerX.equalToSuperview()
            make.top.equalTo(suppliersStackView.snp.bottom)
        }
        
        addDateButton.layer.cornerRadius = 12
        removeDateButton.layer.cornerRadius = 12
        addSupplierButton.layer.cornerRadius = 12
        removeSupplierButton.layer.cornerRadius = 12

        contentView.snp.makeConstraints {
            $0.top.bottom.equalTo(scrollView)
            $0.left.right.equalTo(scrollView)
            $0.width.equalTo(scrollView)
            $0.bottom.equalTo(positivieButton.snp.bottom).offset(50)
        }
    }
    
    // MARK: - Actions
    
    private func positiveButtonAction() {
        print("did tap positive button")
    }
}
