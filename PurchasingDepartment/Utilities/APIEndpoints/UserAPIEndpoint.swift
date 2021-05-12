import Alamofire
import Foundation

enum UserAPIEndpoint: APIEndpoint {
    
    case login(login: String, password: String)
    case register(login: String, password: String, name: String, surname: String, email: String, phone: String)
    
    var baseURLString: String {
        APIConstants.baseURL
    }
    
    var endpoint: String {
        switch self {
        case .login(_, _):
            return "/login"
        case .register(_, _, _, _, _, _):
            return "/users"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .login(_, _):
            return .post
        case .register(_, _, _, _, _, _):
            return .post
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case let .login(login, password):
            return ["login": login, "password": password]
        case let .register(login, password, name, surname, email, phone):
            return [
                "login": login,
                "password": password,
                "name": name,
                "surname": surname,
                "email": email,
                "phone": phone,
                "role": false
            ]
        }
    }
}
