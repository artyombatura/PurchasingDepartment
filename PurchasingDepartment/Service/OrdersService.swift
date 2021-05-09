import Foundation

protocol OrdersServiceProtocol {
    func getOrders(for status: JobStatus, completion: @escaping ((Result<[Order], Error>) -> Void))
}

class OrdersService: OrdersServiceProtocol {
    func getOrders(for status: JobStatus, completion: @escaping ((Result<[Order], Error>) -> Void)) {
        completion(.success([]))

    }
}

class FakeOrdersService: OrdersServiceProtocol {
    func getOrders(for status: JobStatus, completion: @escaping ((Result<[Order], Error>) -> Void)) {
        var fakeSuppliers: [Supplier]?
        FakeSuppliersService().getSuppliers { result in
            fakeSuppliers = try? result.get()
        }
        var orders: [Order] = [
            // requested
            Order(id: "1",
                  name: "Ручка синяя",
                  partNumber: "011_dsa_12",
                  numberOfItems: 10,
                  requestNumber: 113,
                  note: nil,
                  date: nil,
                  status: .requested,
                  selectedPrice: nil,
                  suppliers: nil,
                  selectedSupplier: nil),
            Order(id: "1",
                  name: "Ручка синяя",
                  partNumber: "011_dsa_12",
                  numberOfItems: 10,
                  requestNumber: 114,
                  note: nil,
                  date: nil,
                  status: .requested,
                  selectedPrice: nil,
                  suppliers: nil,
                  selectedSupplier: nil),
            // awaitingForPrice
            Order(id: "1",
                  name: "Ручка синяя",
                  partNumber: "011_dsa_12",
                  numberOfItems: 10,
                  requestNumber: 113,
                  note: "Test note",
                  date: Date(),
                  status: .awaitingForPrice,
                  selectedPrice: nil,
                  suppliers: fakeSuppliers,
                  selectedSupplier: nil),
            Order(id: "1",
                  name: "Ручка синяя",
                  partNumber: "011_dsa_12",
                  numberOfItems: 10,
                  requestNumber: 114,
                  note: "Test note",
                  date: Date(),
                  status: .awaitingForPrice,
                  selectedPrice: nil,
                  suppliers: fakeSuppliers,
                  selectedSupplier: nil),
            // inProgress
            Order(id: "1",
                  name: "Ручка синяя",
                  partNumber: "011_dsa_12",
                  numberOfItems: 10,
                  requestNumber: 113,
                  note: "Test note",
                  date: Date(),
                  status: .inProgress,
                  selectedPrice: 400,
                  suppliers: nil,
                  selectedSupplier: fakeSuppliers?.first),
            Order(id: "1",
                  name: "Ручка синяя",
                  partNumber: "011_dsa_12",
                  numberOfItems: 10,
                  requestNumber: 114,
                  note: "Test note",
                  date: Date(),
                  status: .inProgress,
                  selectedPrice: 400,
                  suppliers: nil,
                  selectedSupplier: fakeSuppliers?.first),
            // dispute
            Order(id: "1",
                  name: "Ручка синяя",
                  partNumber: "011_dsa_12",
                  numberOfItems: 10,
                  requestNumber: 113,
                  note: "Test note",
                  date: Date(),
                  status: .dispute,
                  selectedPrice: 400,
                  suppliers: nil,
                  selectedSupplier: fakeSuppliers?.first),
            Order(id: "1",
                  name: "Ручка синяя",
                  partNumber: "011_dsa_12",
                  numberOfItems: 10,
                  requestNumber: 114,
                  note: "Test note",
                  date: Date(),
                  status: .dispute,
                  selectedPrice: 400,
                  suppliers: nil,
                  selectedSupplier: fakeSuppliers?.first),
            // completed
            Order(id: "1",
                  name: "Ручка синяя",
                  partNumber: "011_dsa_12",
                  numberOfItems: 10,
                  requestNumber: 113,
                  note: "Test note",
                  date: Date(),
                  status: .completed,
                  selectedPrice: 400,
                  suppliers: nil,
                  selectedSupplier: fakeSuppliers?.first),
            Order(id: "1",
                  name: "Ручка синяя",
                  partNumber: "011_dsa_12",
                  numberOfItems: 10,
                  requestNumber: 114,
                  note: "Test note",
                  date: Date(),
                  status: .completed,
                  selectedPrice: 400,
                  suppliers: nil,
                  selectedSupplier: fakeSuppliers?.first),
        ]
        orders.removeAll { $0.status != status }
        completion(.success(orders))
    }
}
