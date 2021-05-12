import UIKit

class AlertDispatcher {
    
    init() { }
    
    public func showInfoAlert(title: String?, message: String?, okAction: (() -> Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ок", style: .default) { _ in
            alertController.dismiss(animated: true, completion: nil)
            okAction?()
        }
        alertController.addAction(okAction)
        DispatchQueue.main.async {
            self.topMostController?.present(alertController, animated: true, completion: nil)
        }
    }
    
    private var topMostController: UIViewController? {
        var topController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController
        while (topController?.presentedViewController) != nil {
            topController = topController?.presentedViewController
        }
        if topController is UIAlertController {
            return nil
        }
        return topController
    }
}
