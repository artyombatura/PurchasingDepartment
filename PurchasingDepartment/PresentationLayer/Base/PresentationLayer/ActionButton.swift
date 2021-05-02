import UIKit

class ActionButton: UIButton {
    
    var action: (() -> Void)?
    
    var title: String? {
        didSet {
            let attributedTitle = NSAttributedString(string: title ?? "", attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold),
                NSAttributedString.Key.foregroundColor: UIColor.white
            ])

            setAttributedTitle(attributedTitle, for: .normal)
        }
    }
    
    init() {
        super.init(frame: .zero)
        addTarget(self, action: #selector(onTap), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    // MARK: - Public methods
    
    public func setAction(_ action: (() -> Void)? = nil) {
        self.action = action
    }
    
    // MARK: - Private methods
    
    @objc private func onTap() {
         action?()
    }
}
