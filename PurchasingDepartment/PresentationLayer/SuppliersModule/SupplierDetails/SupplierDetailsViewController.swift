import UIKit

class SupplierDetailsViewController: UIViewController {
    enum ScreenState {
        case view
        case create
    }
    
    let context: AppContext
    
    let state: ScreenState
    let supplier: Supplier?
    
    init(context: AppContext, supplier: Supplier?, for state: ScreenState) {
        self.context = context
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
        print("DID SELECT SAVE NEW SUPPLIER")
    }
}
