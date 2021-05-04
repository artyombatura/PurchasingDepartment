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
        var orders: [Order] = [
            Order(requestNumber: 113, date: Date(), status: .requested, totalPrice: 100, note: "Test Note"),
            Order(requestNumber: 113, date: Date(), status: .requested, totalPrice: 100, note: "Test Note"),
            Order(requestNumber: 113, date: Date(), status: .requested, totalPrice: 100, note: "Test Note"),
            Order(requestNumber: 114, date: Date(), status: .requested, totalPrice: 100, note: "Test Note"),
            Order(requestNumber: 114, date: Date(), status: .requested, totalPrice: 100, note: "Test Note"),
            Order(requestNumber: 114, date: Date(), status: .requested, totalPrice: 100, note: "Test Note"),
            Order(requestNumber: 113, date: Date(), status: .awaitingForPrice, totalPrice: 100, note: "Test Note"),
            Order(requestNumber: 113, date: Date(), status: .awaitingForPrice, totalPrice: 100, note: "Test Note"),
            Order(requestNumber: 113, date: Date(), status: .awaitingForPrice, totalPrice: 100, note: "Test Note"),
            Order(requestNumber: 114, date: Date(), status: .awaitingForPrice, totalPrice: 100, note: "Test Note"),
            Order(requestNumber: 114, date: Date(), status: .awaitingForPrice, totalPrice: 100, note: "Test Note"),
            Order(requestNumber: 114, date: Date(), status: .awaitingForPrice, totalPrice: 100, note: "Test Note"),
            Order(requestNumber: 113, date: Date(), status: .inProgress, totalPrice: 100, note: "Test Note"),
            Order(requestNumber: 113, date: Date(), status: .inProgress, totalPrice: 100, note: "Test Note"),
            Order(requestNumber: 113, date: Date(), status: .inProgress, totalPrice: 100, note: "Test Note"),
            Order(requestNumber: 114, date: Date(), status: .inProgress, totalPrice: 100, note: "Test Note"),
            Order(requestNumber: 114, date: Date(), status: .inProgress, totalPrice: 100, note: "Test Note"),
            Order(requestNumber: 114, date: Date(), status: .inProgress, totalPrice: 100, note: "Test Note"),
            Order(requestNumber: 113, date: Date(), status: .dispute, totalPrice: 100, note: "Test Note"),
            Order(requestNumber: 113, date: Date(), status: .dispute, totalPrice: 100, note: "Test Note"),
            Order(requestNumber: 113, date: Date(), status: .dispute, totalPrice: 100, note: "Test Note"),
            Order(requestNumber: 114, date: Date(), status: .dispute, totalPrice: 100, note: "Test Note"),
            Order(requestNumber: 114, date: Date(), status: .dispute, totalPrice: 100, note: "Test Note"),
            Order(requestNumber: 114, date: Date(), status: .dispute, totalPrice: 100, note: "Test Note"),
            Order(requestNumber: 113, date: Date(), status: .completed, totalPrice: 100, note: "Test Note"),
            Order(requestNumber: 113, date: Date(), status: .completed, totalPrice: 100, note: "Test Note"),
            Order(requestNumber: 113, date: Date(), status: .completed, totalPrice: 100, note: "Test Note"),
            Order(requestNumber: 114, date: Date(), status: .completed, totalPrice: 100, note: "Test Note"),
            Order(requestNumber: 114, date: Date(), status: .completed, totalPrice: 100, note: "Test Note"),
            Order(requestNumber: 114, date: Date(), status: .completed, totalPrice: 100, note: "Test Note"),
        ]
        orders.removeAll { $0.status != status }
        completion(.success(orders))
    }
}
