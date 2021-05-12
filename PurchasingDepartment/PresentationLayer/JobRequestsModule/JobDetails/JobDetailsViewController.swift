import UIKit

class JobDetailsViewController: BaseLoableViewController {
    
    var order: Order
    let context: AppContext
    let coordinator: JobsRequestCoordinator
    
    init(order: Order, context: AppContext, coordinator: JobsRequestCoordinator) {
        self.order = order
        self.context = context
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
        title = order.status.plainTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let customView = JobDetailsView(order: order, delegate: self, context: context)
        customView.update(for: order)
        view = customView
    }
    
}

extension JobDetailsViewController: JobDetailsViewDelegate {
    func jobDetailsViewDidSelectAddDate(view: JobDetailsView, date: Date, dateFormatter: DateFormatter) {
        let dateString = dateFormatter.string(from: date)
        self.order.date = dateString
        view.order.date = dateString
        view.updateDate(with: dateString)
    }
    
    func jodDetailsViewDidSelectRemoveDate(view: JobDetailsView) {
        guard order.date != nil else {
            return
        }
        order.date = nil
        view.order.date = nil
        view.updateDate(with: "")
    }
    
    func jobDetailsViewDidSelectRemoveSupplier(view: JobDetailsView, supplier: Supplier) {
        self.order.suppliers?.removeAll(where: { $0.id == supplier.id })
    }
    
    func jobDetailsViewShouldShow(view: JobDetailsView, alert: UIAlertController) {
        present(alert, animated: true, completion: nil)
    }
    
    func jobDetailsViewDidSelectSupplierAndPrice(view: JobDetailsView, supplier: Supplier, price: Double) {
        self.order.selectedSupplierId = supplier.id
        self.order.selectedPrice = price
    }
    
    func jobDetailsViewDidDeselectSupplierAndPrice(view: JobDetailsView) {
        self.order.selectedSupplierId = nil
        self.order.selectedPrice = nil
    }
    
    func jobDetailsViewOnPositiveButton(view: JobDetailsView) {
        switch order.status {
        case .requested:
            order.note = view.note
            if order.date == nil || order.suppliers == nil || order.note == nil {
                context.alertDispatcher.showInfoAlert(title: "Заполните все поля", message: nil, okAction: nil)
            } else {
                order.status = .awaitingForPrice
                sendOrder()
            }
            
        case .awaitingForPrice:
            if order.selectedPrice == nil || order.selectedSupplierId == nil {
                context.alertDispatcher.showInfoAlert(title: "Заполните все поля", message: nil, okAction: nil)
            } else {
                order.status = .inProgress
                sendOrder()
            }
            
        case .inProgress, .awaitingForPrice, .dispute:
            order.status = .completed
            sendOrder()
            
        default:
            break
        }
    }
    
    func jobDetailsViewOnNegativeButton(view: JobDetailsView) {
        if order.status == .inProgress {
            order.status = .dispute
            sendOrder()
        }
    }
    
    private func sendOrder() {
        isLoading = true
        context.ordersService.postOrder(order: order) { [weak self] error in
            guard let self = self else {
                return
            }
            if let _ = error {
                self.context.alertDispatcher.showInfoAlert(title: "Ошибка сети", message: nil) {
                    self.isLoading = false
                }
            } else {
                self.isLoading = false
                self.coordinator.popToRoot(animated: true, completion: nil)
            }
        }
    }
}
