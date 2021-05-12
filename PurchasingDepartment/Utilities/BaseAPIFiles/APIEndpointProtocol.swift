import Alamofire

protocol APIEndpoint {
    var baseURLString: String { get }
    
    var url: URL? { get }
    
    var endpoint: String { get }
    
    var method: HTTPMethod { get }
    
    var parameters: Parameters? { get }
    
    var encoding: ParameterEncoding { get }
    
    var headers: HTTPHeaders? { get }
}

extension APIEndpoint {
    var url: URL? {
        return URL(string: baseURLString.appending(endpoint))
    }
    
    var encoding: ParameterEncoding {
        JSONEncoding.default
    }
    
    var headers: HTTPHeaders? {
        let header = HTTPHeader(name: "Content-Type", value: "application/json")
        return HTTPHeaders([header])
    }
}
