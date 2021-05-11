import UIKit

class SuppliersViewController: BaseLoableViewController {
    
    var coordinator: SuppliersCoordinatorProtocol?
    var context: AppContext
    
    private var suppliers: [Supplier] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
    
    init(context: AppContext, coordinator: SuppliersCoordinatorProtocol) {
        self.coordinator = coordinator
        self.context = context
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupUI()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addNewSupplierAction))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetch()
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func fetch() {
        self.isLoading = true
        context.suppliersService.getSuppliers { [weak self] result in
            switch result {
            case let .success(suppliers):
                self?.suppliers = suppliers
                self?.isLoading = false
            case .failure(_):
                self?.context.alertDispatcher.showInfoAlert(title: "Ошибка сети", message: "") {
                    self?.isLoading = false
                }
            }
        }
    }
    
    // MARK: - Actions
    
    @objc private func addNewSupplierAction() {
        coordinator?.didSelectCreateNewSupplier()
    }
}

extension SuppliersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let supplier = suppliers[indexPath.row]
        coordinator?.didSelect(supplier: supplier)
        
    }
}

extension SuppliersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return suppliers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = suppliers[indexPath.row].name
        cell.selectionStyle = .none
        return cell
    }
}
