import UIKit

protocol JobDetailsViewDelegate: AnyObject {
    func jobDetailsViewDidSelectAddDate(view: JobDetailsView, date: Date, dateFormatter: DateFormatter)
    func jodDetailsViewDidSelectRemoveDate(view: JobDetailsView)
    
    func jobDetailsViewDidSelectRemoveSupplier(view: JobDetailsView, supplier: Supplier)
    
    func jobDetailsViewShouldShow(view: JobDetailsView, alert: UIAlertController)
    
    func jobDetailsViewDidSelectSupplierAndPrice(view: JobDetailsView, supplier: Supplier, price: Double)
    func jobDetailsViewDidDeselectSupplierAndPrice(view: JobDetailsView)
}

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
        tf.tfState = .notEditable
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
        tf.tfState = .notEditable
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
        tf.tfState = .notEditable
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
            self?.addDate()
        }
        return b
    }()
    
    private lazy var removeDateButton: AccessoryButtonItem = {
        let b = AccessoryButtonItem()
        b.displayType = .remove
        b.action = { [weak self] in
            self?.removeDate()
        }
        b.availability = .disabled
        return b
    }()
    
    private lazy var selectedDateTextField: UnderlinedStateableTextField = {
        let l = UnderlinedStateableTextField()
        l.lineColor = .white
        l.placeholder = "Выберите дату, нажав '+'"
        return l
    }()
    
    private lazy var suppliersTitleLabel: UILabel = {
        let l = UILabel()
        l.text = "Поставщики:"
        l.font = UIFont.app16BoldFont
        return l
    }()
    
    private lazy var suppliersStackView: UIStackView = {
        let sv = UIStackView()
        sv.alignment = .center
        sv.distribution = .equalSpacing
        sv.axis = .vertical
        sv.spacing = 10
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
    
    // Date picker
    private lazy var datePicker: UIDatePicker = {
        let expectedPickerFrame = CGRect(x: 0,
                                   y: 0,
                                   width: self.bounds.width,
                                   height: 250.0)
        let picker = UIDatePicker(frame: expectedPickerFrame)
        picker.datePickerMode = .date
        picker.date = Date()
        picker.minimumDate = Date()
        picker.preferredDatePickerStyle = .wheels
        picker.sizeToFit()
        return picker
    }()
    
    var order: Order
    weak var delegate: JobDetailsViewDelegate?
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = AppContext.Constant.dateFormate
        return formatter
    }()
    
    init(order: Order, delegate: JobDetailsViewDelegate?) {
        self.order = order
        self.delegate = delegate
        super.init()
        self.backgroundColor = .white
        self.scrollView.backgroundColor = .white
        
        setupUI()
        
        configUserAccessability()
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
        contentView.addSubview(selectedDateTextField)
        contentView.addSubview(suppliersTitleLabel)
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
        
        selectedDateTextField.snp.makeConstraints { make in
            make.top.equalTo(dateTitleLabel.snp.bottom).offset(modulesVerticalOffset)
            make.leading.trailing.equalTo(nameTitleLabel)
            make.height.equalTo(tfHeight)
        }
        
        suppliersTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(selectedDateTextField.snp.bottom).offset(verticalOffset)
            make.leading.trailing.equalTo(nameTitleLabel)
            make.height.equalTo(titleHeight)
        }
        
        suppliersStackView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(nameTitleLabel)
            make.top.equalTo(suppliersTitleLabel.snp.bottom).offset(verticalOffset)
        }
        
        positivieButton.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(48)
            make.centerX.equalToSuperview()
            make.top.equalTo(suppliersStackView.snp.bottom).offset(40)
        }
        
        addDateButton.layer.cornerRadius = 12
        removeDateButton.layer.cornerRadius = 12

        contentView.snp.makeConstraints {
            $0.top.bottom.equalTo(scrollView)
            $0.left.right.equalTo(scrollView)
            $0.width.equalTo(scrollView)
            $0.bottom.equalTo(positivieButton.snp.bottom).offset(40)
        }
    }
    
    // MARK: - Actions
    
    private func positiveButtonAction() {
        print("did tap positive button")
    }
    
    private func addDate() {
        let expectedToolbarFrame = CGRect(x: 0,
                                          y: 0,
                                          width: self.bounds.width,
                                          height: 44.0)
        let toolbar = UIToolbar(frame: expectedToolbarFrame)
        let cancelAction = UIBarButtonItem(title: "Отменить",
                                           style: .plain,
                                           target: self,
                                           action: #selector(cancelDateSelectionAction))
        let acceptAction = UIBarButtonItem(title: "Выбрать",
                                           style: .plain,
                                           target: self,
                                           action: #selector(selectDateFromPickerAction))
        toolbar.setItems([cancelAction, acceptAction], animated: true)
        
        selectedDateTextField.inputView = self.datePicker
        selectedDateTextField.inputAccessoryView = toolbar
        selectedDateTextField.becomeFirstResponder()
    }
    
    private func removeDate() {
        self.delegate?.jodDetailsViewDidSelectRemoveDate(view: self)
    }
    
    @objc private func cancelDateSelectionAction() {
        selectedDateTextField.resignFirstResponder()
        datePicker.date = Date()
    }
    
    @objc private func selectDateFromPickerAction() {
        let date = datePicker.date
        self.delegate?.jobDetailsViewDidSelectAddDate(view: self, date: date, dateFormatter: dateFormatter)
        selectedDateTextField.resignFirstResponder()
        datePicker.date = Date()
    }
    
    // MARK: - Public methods
    
    public func updateDate(with date: String) {
        self.selectedDateTextField.text = date
        if date.isEmpty {
            removeDateButton.availability = .disabled
            addDateButton.availability = .active
        } else {
            removeDateButton.availability = .active
            addDateButton.availability = .disabled
        }
    }
    
    public func update(for order: Order) {
        /// Config all subviews
        nameTextField.text = order.name
        partNumberTextField.text = order.partNumber
        noteTextField.text = order.note ?? ""
        countTextField.text = String(order.numberOfItems)
        if let date = order.date {
            selectedDateTextField.text = date
        }
    
        /// Config suppliers subviews
        switch order.status {
        case .requested:
            if let suppliers = order.suppliers {
                suppliers.forEach { supplier in
                    let supplierView = SupplierSubview(supplier: supplier)
                    supplierView.update(for: supplier, viewState: .canBeRemoved)
                    supplierView.removeAction = { [weak self] view in
                        guard let self = self else {
                            return
                        }
                        self.delegate?.jobDetailsViewDidSelectRemoveSupplier(view: self, supplier: supplier)
                        self.order.suppliers?.removeAll(where: { $0.id == supplier.id })
                        view.removeFromSuperview()
                    }
                    suppliersStackView.addArrangedSubview(supplierView)
                    supplierView.snp.makeConstraints {
                        $0.leading.trailing.equalToSuperview()
                        $0.height.equalTo(50)
                    }
                }
            }
        case .awaitingForPrice:
            if let suppliers = order.suppliers {
                suppliers.forEach { supplier in
                    let supplierView = SupplierSubview(supplier: supplier)
                    supplierView.update(for: supplier, viewState: .notSelected)
                    
                    supplierView.tapAction = { [weak self] supplierView in
                        guard let self = self else {
                            return
                        }
                        switch supplierView.viewState {
                        case .notSelected:
                            let alertController = UIAlertController(title: "Укажите цену",
                                                                    message: "Введите цену поставщика",
                                                                    preferredStyle: .alert)
                            alertController.addTextField { tf in
                                tf.accessibilityIdentifier = "price_text_field"
                                tf.keyboardType = .numberPad
                            }
                            let cancelAction = UIAlertAction(title: "Отмена",
                                                             style: .cancel) { _ in
                                alertController.dismiss(animated: true, completion: nil)
                            }
                            let acceptAction = UIAlertAction(title: "Сохранить",
                                                             style: .default) { _ in
                                guard let priceTF = alertController.textFields?.first(where: { $0.accessibilityIdentifier == "price_text_field" }),
                                      let price = Double(priceTF.text ?? "") else {
                                    return
                                }
                                
                                self.delegate?.jobDetailsViewDidSelectSupplierAndPrice(view: self, supplier: supplier, price: price)
                                self.order.selectedSupplier = supplier
                                self.order.selectedPrice = price
                                
                                supplierView.update(for: supplier, viewState: .selected(price: price))
                                alertController.dismiss(animated: true, completion: nil)
                            }
                            alertController.addAction(cancelAction)
                            alertController.addAction(acceptAction)
                            self.delegate?.jobDetailsViewShouldShow(view: self, alert: alertController)
                            
                        case .selected(_):
                            self.delegate?.jobDetailsViewDidDeselectSupplierAndPrice(view: self)
                            self.order.selectedSupplier = nil
                            self.order.selectedPrice = nil
                            supplierView.update(for: supplier, viewState: .notSelected)
                            
                        default:
                            break
                        }
                    }
                    
                    suppliersStackView.addArrangedSubview(supplierView)
                    supplierView.snp.makeConstraints {
                        $0.leading.trailing.equalToSuperview()
                        $0.height.equalTo(50)
                    }
                }
            }
            
        case .inProgress, .dispute, .completed:
            if let selectedSupplier = order.selectedSupplier,
               let selectedPrice = order.selectedPrice {
                let supplierView = SupplierSubview(supplier: selectedSupplier)
                supplierView.update(for: selectedSupplier, viewState: .selected(price: selectedPrice))
                suppliersStackView.addArrangedSubview(supplierView)
                supplierView.snp.makeConstraints {
                    $0.leading.trailing.equalToSuperview()
                    $0.height.equalTo(50)
                }
            }
        }
    }
    
    private func configUserAccessability() {
        switch order.status {
        case .requested:
            nameTextField.tfState = .notEditable
            partNumberTextField.tfState = .notEditable
            noteTextField.tfState = .editable
            countTextField.tfState = .notEditable
            selectedDateTextField.tfState = .editable
            removeDateButton.availability = .disabled
            addDateButton.availability = .active
            
        case .awaitingForPrice, .inProgress, .dispute, .completed:
            nameTextField.tfState = .notEditable
            partNumberTextField.tfState = .notEditable
            noteTextField.tfState = .notEditable
            countTextField.tfState = .notEditable
            selectedDateTextField.tfState = .notEditable
            removeDateButton.availability = .disabled
            addDateButton.availability = .disabled
            removeDateButton.isHidden = true
            addDateButton.isHidden = true
        }
    }
}
