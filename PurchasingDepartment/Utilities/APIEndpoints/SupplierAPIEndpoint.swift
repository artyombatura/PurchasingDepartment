import Alamofire
import Foundation

enum SupplierAPIEndpoint: APIEndpoint {
    
    case getAllSuppliers
    
    var baseURLString: String {
        APIConstants.baseURL
    }
    
    var endpoint: String {
        switch self {
        case .getAllSuppliers:
            return "/suppliers"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getAllSuppliers:
            return .get
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getAllSuppliers:
            return nil
        }
    }
}
