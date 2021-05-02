import UIKit
import SnapKit

class UnderlinedTextField: UITextField {
    
    var lineColor: UIColor = .underlineTextFieldColor {
        didSet {
            lineView.backgroundColor = lineColor
        }
    }
    
    var lineHeight: CGFloat = 0.5 {
        didSet {
            lineView.snp.updateConstraints {
                $0.height.equalTo(lineHeight)
            }
        }
    }
    
    private lazy var lineView: UIView = {
        let line = UIView()
        line.backgroundColor = lineColor
        return line
    }()
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        addSubview(lineView)
        lineView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(lineHeight)
        }
    }
}
