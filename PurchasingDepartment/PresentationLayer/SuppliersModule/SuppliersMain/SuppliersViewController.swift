import UIKit

class SuppliersViewController: UIViewController {
    
    var coordinator: SuppliersCoordinatorProtocol?
    
    private var suppliers: [Supplier] = [
        Supplier(name: "ООО Кот в говне", email: "govno_kursach@mail.ru", address: "ул. Хуй", phone: "228_1337_422"),
        Supplier(name: "ООО Кот в говне", email: "govno_kursach@mail.ru", address: "ул. Хуй", phone: "228_1337_422"),
        Supplier(name: "ООО Кот в говне", email: "govno_kursach@mail.ru", address: "ул. Хуй", phone: "228_1337_422"),
        Supplier(name: "ООО Кот в говне", email: "govno_kursach@mail.ru", address: "ул. Хуй", phone: "228_1337_422"),
        Supplier(name: "ООО Кот в говне", email: "govno_kursach@mail.ru", address: "ул. Хуй", phone: "228_1337_422"),
        Supplier(name: "ООО Кот в говне", email: "govno_kursach@mail.ru", address: "ул. Хуй", phone: "228_1337_422"),
        Supplier(name: "ООО Кот в говне", email: "govno_kursach@mail.ru", address: "ул. Хуй", phone: "228_1337_422"),
        Supplier(name: "ООО Кот в говне", email: "govno_kursach@mail.ru", address: "ул. Хуй", phone: "228_1337_422"),
        Supplier(name: "ООО Кот в говне", email: "govno_kursach@mail.ru", address: "ул. Хуй", phone: "228_1337_422"),
        Supplier(name: "ООО Кот в говне", email: "govno_kursach@mail.ru", address: "ул. Хуй", phone: "228_1337_422"),
        Supplier(name: "ООО Кот в говне", email: "govno_kursach@mail.ru", address: "ул. Хуй", phone: "228_1337_422"),
        Supplier(name: "ООО Кот в говне", email: "govno_kursach@mail.ru", address: "ул. Хуй", phone: "228_1337_422")
    ]
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
    
    init(coordinator: SuppliersCoordinatorProtocol) {
        self.coordinator = coordinator
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
    
    private func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
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
