import UIKit

class SupplierProductView: UIView {
    
    let product: ProductCatalog
    
    private lazy var containerView: UIView = {
        let v = UIView(frame: .zero)
        v.backgroundColor = .white
        return v
    }()
    
    private lazy var contentStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [topLabel, bottomLabel])
        sv.alignment = .center
        sv.distribution = .fillEqually
        sv.axis = .vertical
        return sv
    }()
    
    private lazy var topLabel: UILabel = {
        let l = UILabel()
        l.text = ""
        return l
    }()
    
    private lazy var bottomLabel: UILabel = {
        let l = UILabel()
        l.text = ""
        return l
    }()
    
    init(product: ProductCatalog) {
        self.product = product
        super.init(frame: .zero)
        setupUI()
        configure(for: product)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    private func configure(for item: ProductCatalog) {
        let nameTitle = "Название: "
        let nameAndMeasurement = "\(item.name) (\(item.measurementUnit))"
        
        let partNumberTitle = "Артикул: "
        
        let nameTitleAttributed = NSAttributedString(string: nameTitle, attributes: [
            NSAttributedString.Key.font: UIFont.app16Font,
            NSAttributedString.Key.foregroundColor: UIColor.black
        ])
        
        let nameAndMeasurementAttributed = NSAttributedString(string: nameAndMeasurement, attributes: [
            NSAttributedString.Key.font: UIFont.app16Font,
            NSAttributedString.Key.foregroundColor: UIColor.appGrayColor
        ])
        let topAttributedTitle = NSMutableAttributedString(attributedString: nameTitleAttributed)
        topAttributedTitle.append(nameAndMeasurementAttributed)
        
        let partNumberTitleAttributed = NSAttributedString(string: partNumberTitle, attributes: [
            NSAttributedString.Key.font: UIFont.app16Font,
            NSAttributedString.Key.foregroundColor: UIColor.black
        ])
        let partNumberAttributed = NSAttributedString(string: item.partNumber, attributes: [
            NSAttributedString.Key.font: UIFont.app16Font,
            NSAttributedString.Key.foregroundColor: UIColor.appGrayColor
        ])
        let bottomAttributedTitle = NSMutableAttributedString(attributedString: partNumberTitleAttributed)
        bottomAttributedTitle.append(partNumberAttributed)
        
        
        topLabel.attributedText = topAttributedTitle
        bottomLabel.attributedText = bottomAttributedTitle
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        addSubview(containerView)
        containerView.addSubview(contentStackView)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        topLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview()
        }
        
        bottomLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview()
        }
    }
}
