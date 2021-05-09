import UIKit

class JobDetailsViewController: UIViewController {
    
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
        let customView = JobDetailsView(order: order, delegate: self)
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
}
