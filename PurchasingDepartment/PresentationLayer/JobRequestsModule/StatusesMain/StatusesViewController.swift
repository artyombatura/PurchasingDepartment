import UIKit

class StatusesViewController: UIViewController {
    
    var coordinator: JobsRequestCoordinator?
    let items: [JobStatus] = [.requested, .awaitingForPrice, .inProgress, .dispute, .completed]
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.tableFooterView = UIView()
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
    
    init(coordinator: JobsRequestCoordinator) {
        self.coordinator = coordinator
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
    }
}

extension StatusesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let status = items[indexPath.row]
        coordinator?.showJobsList(for: status)
    }
}

extension StatusesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = items[indexPath.row].plainTitle
        return cell
    }
}
