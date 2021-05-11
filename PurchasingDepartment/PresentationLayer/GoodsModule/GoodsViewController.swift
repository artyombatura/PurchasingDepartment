import UIKit

class GoodsViewController: BaseLoableViewController {
    
    var context: AppContext
    
    private var items: [ProductCatalog] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.register(GoodsTableViewCell.self, forCellReuseIdentifier: String(describing: GoodsTableViewCell.self))
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
    
    init(context: AppContext) {
        self.context = context
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetch()
        setupUI()
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func fetch() {
        isLoading = true
        context.productsService.getAllProducts { [weak self] result in
            switch result {
            case let .success(products):
                guard let products = products else {
                    return
                }
                self?.items = products
                self?.isLoading = false
            case let .failure(_):
                self?.context.alertDispatcher.showInfoAlert(title: "Ошибка сети", message: nil, okAction: {
                    self?.isLoading = false
                })
            }
        }
    }
}

extension GoodsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

extension GoodsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: GoodsTableViewCell.self), for: indexPath) as? GoodsTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(for: items[indexPath.row])
        return cell
    }
}
