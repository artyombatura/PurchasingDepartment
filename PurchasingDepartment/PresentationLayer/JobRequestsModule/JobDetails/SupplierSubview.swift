import UIKit

class SupplierSubview: UIView {
    
    enum ViewState {
        case accessoryHidden
        case normal
        case selected
    }
    
    // MARK: - Subviews
    
    private lazy var viewStateInfoView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.appGrayColor
        return v
    }()
    
    // MARK: - Variables
    
    let supplier: Supplier
    var viewState: ViewState = .normal {
        didSet {
            switch viewState {
            case .accessoryHidden:
                viewStateInfoView.isHidden = true
            case .normal:
                viewStateInfoView.isHidden = false
            case .selected:
                viewStateInfoView.isHidden = false
            }
        }
    }
    
    init(supplier: Supplier) {
        self.supplier = supplier
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
