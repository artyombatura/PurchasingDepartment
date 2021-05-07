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
    
    var order: Order
    
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
        
        addDateButton.layer.cornerRadius = 12
        removeDateButton.layer.cornerRadius = 12

        contentView.snp.makeConstraints {
            $0.top.bottom.equalTo(scrollView)
            $0.left.right.equalTo(scrollView)
            $0.width.equalTo(scrollView)
            $0.height.equalToSuperview()
        }
    }
}
