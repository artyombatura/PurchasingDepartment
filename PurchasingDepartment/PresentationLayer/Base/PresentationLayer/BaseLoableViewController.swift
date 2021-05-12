import UIKit

class BaseLoableViewController: UIViewController {
    
    public var isLoading: Bool = false {
        didSet {
            changeLoadingState(isLoading: isLoading)
        }
    }
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.color = .white
        return view
    }()
    
    var prevRightBarButtonItem: UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Private methods
    
    private func changeLoadingState(isLoading: Bool) {
        if isLoading {
            if let rightBarButtonItem = navigationItem.rightBarButtonItem {
                prevRightBarButtonItem = rightBarButtonItem
            }
            loadingIndicator.startAnimating()
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: loadingIndicator)
        } else {
            loadingIndicator.stopAnimating()
            navigationItem.rightBarButtonItem = prevRightBarButtonItem
        }
        self.view.isUserInteractionEnabled = !isLoading
    }
}
