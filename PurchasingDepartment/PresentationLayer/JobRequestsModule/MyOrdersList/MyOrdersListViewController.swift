import Foundation
import UIKit

class MyOrdersListViewController: BaseLoableViewController {
    
    struct SectionViewModel {
        var sectionNumber: Int
        var orders: [Order]
    }
    
    private let coordinator: JobsRequestCoordinator
    private let jobStatus: JobStatus
    private var items: [SectionViewModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private let context: AppContext
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
    
    init(jobStatus: JobStatus, context: AppContext, coordinator: JobsRequestCoordinator) {
        self.coordinator = coordinator
        self.jobStatus = jobStatus
        self.context = context
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        title = jobStatus.plainTitle
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        fetch()
    }
    
    // MARK: - Private methods
    
    private func fetch() {
        isLoading = true
        context.ordersService.getOrders(for: jobStatus) { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case let .success(orders):
                guard var orders = orders else {
                    self.context.alertDispatcher.showInfoAlert(title: "Ошибка сети", message: nil) {
                        self.isLoading = false
                    }
                    return
                }
//                orders.removeAll { $0.status != self.jobStatus }
                self.items = self.prepareOrdersForDisplaying(orders: orders)
                self.isLoading = false
                
            case .failure(_):
                self.context.alertDispatcher.showInfoAlert(title: "Ошибка сети", message: nil) {
                    self.isLoading = false
                }
            }
        }    }
    
    private func prepareOrdersForDisplaying(orders: [Order]) -> [SectionViewModel] {
        let chunkedOrders = Array(Dictionary(grouping: orders){$0.requestNumber}.values)
        let sections = chunkedOrders.map { orders -> SectionViewModel in
            return SectionViewModel(sectionNumber: orders.first?.requestNumber ?? 0, orders: orders)
        }
        return sections
    }
}

extension MyOrdersListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.section].orders[indexPath.row]
        coordinator.showOrderDetails(order: item)
    }
}

extension MyOrdersListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].orders.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Заявка \(items[section].sectionNumber)"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        let order = items[indexPath.section].orders[indexPath.row]
        cell.textLabel?.text = order.name
        cell.detailTextLabel?.text = order.partNumber
        return cell
    }
}
