import UIKit
import SnapKit

class UnderlinedStateableTextField: UITextField {
    
    enum State {
        case notEditable
        case editable
    }
    
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
    
    var tfState: State = .editable {
        didSet {
            switch tfState {
            case .notEditable:
                self.textColor = .lightGray
                self.isUserInteractionEnabled = false
            case .editable:
                self.textColor = .black
                self.isUserInteractionEnabled = true
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
        configure()
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
    
    private func configure() {
        self.font = UIFont.app16Font
    }
}
