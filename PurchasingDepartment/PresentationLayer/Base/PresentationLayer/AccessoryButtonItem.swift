import UIKit

class AccessoryButtonItem: UIButton {
    enum DisplayType {
        case add
        case remove
    }
    enum Availability {
        case active
        case disabled
    }
    
    init() {
        super.init(frame: .zero)
        self.addTarget(self, action: #selector(onTap), for: .touchUpInside)
        self.backgroundColor = UIColor.buttonEnabledColor
        self.setTitleColor(.black, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public var displayType: DisplayType = .add {
        didSet {
            switch displayType {
            case .add:
                setTitle("+", for: .normal)
            case .remove:
                setTitle("-", for: .normal)
            }
        }
    }
    
    public var availability: Availability = .active {
        didSet {
            switch availability {
            case .active:
                backgroundColor = UIColor.buttonEnabledColor
            case .disabled:
                backgroundColor = UIColor.buttonDisabledColor
            }
        }
    }
    
    public var action: (() -> Void)?
    
    @objc private func onTap() {
        if availability == .disabled { return }
        action?()
    }
}
