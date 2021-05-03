import UIKit
import SnapKit

class GoodsTableViewCell: UITableViewCell {
    
    private lazy var contentStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [topLabel, bottomLabel])
        sv.alignment = .center
        sv.distribution = .fillEqually
        sv.axis = .vertical
        return sv
    }()
    
    private lazy var topLabel: UILabel = {
        let l = UILabel()
        l.text = "12332213"
        return l
    }()
    
    private lazy var bottomLabel: UILabel = {
        let l = UILabel()
        l.text = "31231231"
        return l
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    public func configure(for item: ProductCatalog) {
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
        addSubview(contentStackView)
        contentStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        topLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
        }
        
        bottomLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
        }
    }
}
