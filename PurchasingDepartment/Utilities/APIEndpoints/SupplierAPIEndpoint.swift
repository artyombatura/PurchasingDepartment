import Alamofire
import Foundation

enum SupplierAPIEndpoint: APIEndpoint {
    
    case getAllSuppliers
    case getSupplier(id: Int)
    case registerSupplier(name: String, email: String, address: String, phone: String)
    
    var baseURLString: String {
        APIConstants.baseURL
    }
    
    var endpoint: String {
        switch self {
        case .getAllSuppliers:
            return "/suppliers"
        case let .getSupplier(id):
            return "/supplier?id=\(String(id))"
        case .registerSupplier(_, _, _, _):
            return "/suppliers"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getAllSuppliers, .getSupplier(_):
            return .get
        case .registerSupplier(_, _, _, _):
            return .post
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getAllSuppliers, .getSupplier(_):
            return nil
        case let .registerSupplier(name, email, address, phone):
            return [
                "name": name,
                "email": email,
                "address": address,
                "phone": phone
            ]
        }
    }
}
