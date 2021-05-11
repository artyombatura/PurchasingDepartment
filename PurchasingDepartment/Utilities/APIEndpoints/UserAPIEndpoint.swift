import Alamofire
import Foundation

enum UserAPIEndpoint: APIEndpoint {
    
    case login(login: String, password: String)
    
    var baseURLString: String {
        APIConstants.baseURL
    }
    
    var endpoint: String {
        switch self {
        case .login(_, _):
            return "/login"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .login(_, _):
            return .post
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case let .login(login, password):
            return ["login": login, "password": password]
        }
    }
}
