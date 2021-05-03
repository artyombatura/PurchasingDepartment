import UIKit

class GoodsViewController: UIViewController {
    
    private var items: [ProductCatalog] = [
        ProductCatalog(name: "Ручка синяя", partNumber: "011_dsa_12", measurementUnit: "Шт."),
        ProductCatalog(name: "Ручка синяя", partNumber: "011_dsa_12", measurementUnit: "Шт."),
        ProductCatalog(name: "Ручка синяя", partNumber: "011_dsa_12", measurementUnit: "Шт."),
        ProductCatalog(name: "Ручка синяя", partNumber: "011_dsa_12", measurementUnit: "Шт."),
        ProductCatalog(name: "Ручка синяя", partNumber: "011_dsa_12", measurementUnit: "Шт."),
        ProductCatalog(name: "Ручка синяя", partNumber: "011_dsa_12", measurementUnit: "Шт."),
        ProductCatalog(name: "Ручка синяя", partNumber: "011_dsa_12", measurementUnit: "Шт."),
        ProductCatalog(name: "Ручка синяя", partNumber: "011_dsa_12", measurementUnit: "Шт."),
        ProductCatalog(name: "Ручка синяя", partNumber: "011_dsa_12", measurementUnit: "Шт.")
    ]
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.register(GoodsTableViewCell.self, forCellReuseIdentifier: String(describing: GoodsTableViewCell.self))
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension GoodsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
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
