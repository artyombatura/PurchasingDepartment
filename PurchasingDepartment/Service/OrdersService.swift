import Foundation

protocol OrdersServiceProtocol {
    func getOrders(for status: JobStatus, completion: @escaping ((Result<[Order]?, Error>) -> Void))
    func postOrder(order: Order, completion: @escaping ((Error?) -> Void))
}

class OrdersService: OrdersServiceProtocol {
    func getOrders(for status: JobStatus, completion: @escaping ((Result<[Order]?, Error>) -> Void)) {
        let ordersAPI = OrderAPIEndpoint.getOrders(status: status)
        APIWorker.shared.request(api: ordersAPI, [Order].self) { result in
            completion(result)
        }
    }
    
    func postOrder(order: Order, completion: @escaping ((Error?) -> Void)) {
        let api = OrderAPIEndpoint.sendOrder(order: order)
        APIWorker.shared.postWithoutResponseRequest(api: api) { error in
            completion(error)
        }
    }
}

class FakeOrdersService: OrdersServiceProtocol {
    func getOrders(for status: JobStatus, completion: @escaping ((Result<[Order]?, Error>) -> Void)) {
        var fakeSuppliers: [Supplier]?
        FakeSuppliersService().getSuppliers { result in
            fakeSuppliers = try? result.get()
        }
        var orders: [Order] = [
            // requested
            Order(orderId: 1,
                  name: "Ручка синяя",
                  partNumber: "011_dsa_12",
                  numberOfItems: 10,
                  requestNumber: 113,
                  note: nil,
                  date: nil,
                  status: .requested,
                  selectedPrice: nil,
                  suppliers: fakeSuppliers,
                  selectedSupplierId: nil),
            Order(orderId: 1,
                  name: "Ручка синяя",
                  partNumber: "011_dsa_12",
                  numberOfItems: 10,
                  requestNumber: 114,
                  note: nil,
                  date: nil,
                  status: .requested,
                  selectedPrice: nil,
                  suppliers: fakeSuppliers,
                  selectedSupplierId: nil),
            // awaitingForPrice
            Order(orderId: 1,
                  name: "Ручка синяя",
                  partNumber: "011_dsa_12",
                  numberOfItems: 10,
                  requestNumber: 113,
                  note: "Test note",
                  date: Date().getString(),
                  status: .awaitingForPrice,
                  selectedPrice: nil,
                  suppliers: fakeSuppliers,
                  selectedSupplierId: nil),
            Order(orderId: 1,
                  name: "Ручка синяя",
                  partNumber: "011_dsa_12",
                  numberOfItems: 10,
                  requestNumber: 114,
                  note: "Test note",
                  date: Date().getString(),
                  status: .awaitingForPrice,
                  selectedPrice: nil,
                  suppliers: fakeSuppliers,
                  selectedSupplierId: nil),
            // inProgress
            Order(orderId: 1,
                  name: "Ручка синяя",
                  partNumber: "011_dsa_12",
                  numberOfItems: 10,
                  requestNumber: 113,
                  note: "Test note",
                  date: Date().getString(),
                  status: .inProgress,
                  selectedPrice: 400,
                  suppliers: nil,
                  selectedSupplierId: 1),
            Order(orderId: 1,
                  name: "Ручка синяя",
                  partNumber: "011_dsa_12",
                  numberOfItems: 10,
                  requestNumber: 114,
                  note: "Test note",
                  date: Date().getString(),
                  status: .inProgress,
                  selectedPrice: 400,
                  suppliers: nil,
                  selectedSupplierId: 1),
            // dispute
            Order(orderId: 1,
                  name: "Ручка синяя",
                  partNumber: "011_dsa_12",
                  numberOfItems: 10,
                  requestNumber: 113,
                  note: "Test note",
                  date: Date().getString(),
                  status: .dispute,
                  selectedPrice: 400,
                  suppliers: nil,
                  selectedSupplierId: 1),
            Order(orderId: 1,
                  name: "Ручка синяя",
                  partNumber: "011_dsa_12",
                  numberOfItems: 10,
                  requestNumber: 114,
                  note: "Test note",
                  date: Date().getString(),
                  status: .dispute,
                  selectedPrice: 400,
                  suppliers: nil,
                  selectedSupplierId: 1),
            // completed
            Order(orderId: 1,
                  name: "Ручка синяя",
                  partNumber: "011_dsa_12",
                  numberOfItems: 10,
                  requestNumber: 113,
                  note: "Test note",
                  date: Date().getString(),
                  status: .completed,
                  selectedPrice: 400,
                  suppliers: nil,
                  selectedSupplierId: 1),
            Order(orderId: 1,
                  name: "Ручка синяя",
                  partNumber: "011_dsa_12",
                  numberOfItems: 10,
                  requestNumber: 114,
                  note: "Test note",
                  date: Date().getString(),
                  status: .completed,
                  selectedPrice: 400,
                  suppliers: nil,
                  selectedSupplierId: 1),
        ]
        orders.removeAll { $0.status != status }
        completion(.success(orders))
    }
    
    func postOrder(order: Order, completion: @escaping ((Error?) -> Void)) { }
}
