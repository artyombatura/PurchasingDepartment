import UIKit

class SupplierDetailsViewController: BaseLoableViewController {
    enum ScreenState {
        case view
        case create
    }
    
    let context: AppContext
    let coordinator: SuppliersCoordinator
    
    let state: ScreenState
    let supplier: Supplier?
    
    init(context: AppContext, supplier: Supplier?, for state: ScreenState, coordinator: SuppliersCoordinator) {
        self.context = context
        self.coordinator = coordinator
        self.supplier = supplier
        self.state = state
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let customView = SupplierDetailsView(supplier: supplier, delegate: self, state: state)
        self.view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch state {
        case .create:
            title = "Добавить поставщика"
        case .view:
            title = "Просмотреть поставщика"
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

}

extension SupplierDetailsViewController: SupplierDetailsViewDelegate {
    func supplierDetailsViewDidSelectSave(view: SupplierDetailsView) {
        isLoading = true
        if let name = view.inputedName,
           !name.isEmpty,
           let email = view.inputedEmail,
           !email.isEmpty,
           let phone = view.inputedPhone,
           !phone.isEmpty,
           let address = view.inputedAddress,
           !address.isEmpty {
            context.suppliersService.registerSupplier(name: name,
                                                      email: email,
                                                      address: address,
                                                      phone: phone) { [weak self] error in
                if let _ = error {
                    self?.context.alertDispatcher.showInfoAlert(title: "Ошибка сети", message: nil, okAction: { [weak self] in
                        self?.isLoading = false
                    })
                } else {
                    self?.isLoading = false
                    self?.coordinator.popToRoot(animated: true, completion: nil)
                }
            }
        } else {
            context.alertDispatcher.showInfoAlert(title: "Заполните поля", message: "Заполните все поля и попробуйте снова", okAction: { [weak self] in
                self?.isLoading = false
            })
        }
    }
}
