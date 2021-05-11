import Alamofire

enum ProductsAPIEndpoint: APIEndpoint {
    
    case getProducts
    
    var baseURLString: String {
        APIConstants.baseURL
    }
    
    var endpoint: String {
        switch self {
        case .getProducts:
            return "/products"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getProducts:
            return .get
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getProducts:
            return nil
        }
    }
}
