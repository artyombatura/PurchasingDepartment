import UIKit

/// Public protocol for navigation bar appearence
@objc public protocol NavigationBarAppearance: AnyObject {
    /// True - prefers navigation bar is hidden, else - false
    var prefersNavigationBarHidden: Bool { get }
}

extension UIViewController: NavigationBarAppearance {
    public var prefersNavigationBarHidden: Bool {
        return false
    }
}

/// Base navigation view coontroller
open class BaseNavigationVC: UINavigationController {
    /// Navigation bar color
    open var navigationBarColor: UIColor? = UIColor.blue {
        didSet {
            guard isViewLoaded else {
                return
            }
            updateNavigationBarColor()
        }
    }

    // MARK: init

    public init() {
        super.init(nibName: nil, bundle: nil)
    }

    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: -

    override open func loadView() {
        super.loadView()
        interactivePopGestureRecognizer?.isEnabled = true
        view.tintColor = .black
        edgesForExtendedLayout = .all
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white,
                                             .font: UIFont.systemFont(ofSize: 16, weight: .bold)]

//        navigationBar.backIndicatorImage = UIImage.icArrowBack
//        navigationBar.backIndicatorTransitionMaskImage = UIImage.icArrowBack
        updateNavigationBarColor()
        delegate = self
        setupView()
    }

    /// Function to setup navigation bar
    private func setupView() {
        navigationBar.tintColor = .white
        navigationBar.layer.shadowOffset = CGSize(width: 0, height: 3)
        navigationBar.layer.shadowRadius = 5
        navigationBar.layer.shadowColor = UIColor.black.cgColor
        navigationBar.layer.shadowOpacity = 0.1
    }

    /// Function to update navigation bar color when you set navigationBarColor
    private func updateNavigationBarColor() {
        if let color = navigationBarColor {
            navigationBar.barTintColor = color
        } else {
            navigationBar.barTintColor = nil
        }
    }
}

extension BaseNavigationVC: UINavigationControllerDelegate {
    public func navigationController(_: UINavigationController,
                                     willShow viewController: UIViewController,
                                     animated: Bool)
    {
        setNavigationBarHidden(viewController.prefersNavigationBarHidden, animated: animated)
        viewController.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
