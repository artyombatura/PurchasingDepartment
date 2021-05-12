import Foundation
import Alamofire

enum OrderAPIEndpoint: APIEndpoint {
    case getOrders(status: JobStatus)
    case sendOrder(order: Order)
    
    var baseURLString: String {
        APIConstants.baseURL
    }
    
    var endpoint: String {
        switch self {
        case let .getOrders(status):
            return "/orders?status=\(status.rawValue)"
        case let .sendOrder(_):
            return "/orders"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getOrders(_):
            return .get
        case .sendOrder(_):
            return .post
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getOrders(_):
            return nil
            
        case let .sendOrder(order):
            var suppliersJSON = [[String: Any]]()
            order.suppliers?.forEach({
                suppliersJSON.append([
                    "email": $0.email,
                    "id": $0.id,
                    "phone": $0.phone,
                    "name": $0.name,
                    "address": $0.address
                ])
            })
            
            return [
                "orderId": order.orderId,
                "name": order.name,
                "partNumber": order.partNumber,
                "numberOfItems": order.numberOfItems,
                "requestNumber": order.requestNumber,
                "note": order.note,
                "date": order.date,
                "status": order.status.rawValue,
                "selectedPrice": order.selectedPrice,
                "suppliers": suppliersJSON,
                "selectedSupplierId": order.selectedSupplierId
            ]
        }
    }
}
