import UIKit

class BaseScrollableView: UIView {
    lazy var scrollView: UIScrollView = {
        var sv = UIScrollView()
        sv.showsVerticalScrollIndicator = true
        sv.keyboardDismissMode = .interactive
        return sv
    }()

    init() {
        super.init(frame: .zero)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        let dissmissKeyboardTapGesture = UITapGestureRecognizer(target: self, action: #selector(dissmissKeyboardOnTap))
        addGestureRecognizer(dissmissKeyboardTapGesture)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        NotificationCenter.default.removeObserver(UIResponder.keyboardWillShowNotification)
        NotificationCenter.default.removeObserver(UIResponder.keyboardWillHideNotification)
    }

    // MARK: - Private methods

    // MARK: -

    @objc private func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo,
              var keyboardFrame: CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue else { return }

        keyboardFrame = convert(keyboardFrame, from: nil)

        var contentInset: UIEdgeInsets = scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        scrollView.contentInset = contentInset
    }

    @objc private func keyboardWillHide(notification _: Notification) {
        let contentInset = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }

    @objc private func dissmissKeyboardOnTap() {
        endEditing(true)
    }
}
