import Foundation

// MARK: - GET/getAllOrders(userId: User.id)
/** Order model description by Statuses:
 
 // MARK: - EXPECTED VALUES FROM SERVER
 
 switch jobStatus {
 case requested:
        Order(
            name: String                    -> not nil
            partNumber: String              -> not nil
            numberOfItems: Int              -> not nil
            note: String                    -> nil
            date: Date                      -> nil
            status: String(or JobStatus)    -> not nil
            selectedPrice: Double           -> nil
            suppliers: [Supplier]           -> nil
            selectedSupplier: Supplier      -> nil
        )
 
 case awaitingForPrice:
        Order(
             name: String                    -> not nil
             partNumber: String              -> not nil
             numberOfItems: Int              -> not nil
             note: String                    -> not nil (nil if user sent empty message)
             date: Date                      -> not nil
             status: String(or JobStatus)    -> not nil
             selectedPrice: Double           -> nil
             suppliers: [Supplier]           -> not nil
             selectedSupplier: Supplier      -> nil
         )
 
 case inProgress, .dispute, .completed:
        Order(
             name: String                    -> not nil
             partNumber: String              -> not nil
             numberOfItems: Int              -> not nil
             note: String                    -> not nil (nil if user sent empty message)
             date: Date                      -> not nil
             status: String(or JobStatus)    -> not nil
             selectedPrice: Double           -> not nil
             suppliers: [Supplier]           -> nil (or could be not nil, as you wish)
             selectedSupplier: Supplier      -> not nil
         )
 }
 
 */
struct Order {
    let id: String
    let name: String
    let partNumber: String
    let numberOfItems: Int
    let requestNumber: Int
    var note: String?
    var date: Date?
    var status: JobStatus
    var selectedPrice: Double?
    var suppliers: [Supplier]?
    var selectedSupplier: Supplier?
}
