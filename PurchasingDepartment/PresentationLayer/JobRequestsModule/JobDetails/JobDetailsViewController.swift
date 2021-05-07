import UIKit

class JobDetailsViewController: UIViewController {
    
    let order: Order
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
        let customView = JobDetailsView(order: order)
        view = customView
    }
    
}
