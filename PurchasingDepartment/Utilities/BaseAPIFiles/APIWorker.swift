import Alamofire

class APIWorker {
    
    public static let shared = APIWorker()
    
    private init() { }
    
    func request<T: Decodable>(api: APIEndpoint, _ type: T.Type, completion: @escaping ((Result<T?, Error>) -> Void)) {
        if let url = api.url {
            AF.request(url,
                       method: api.method,
                       parameters: api.parameters,
                       encoding: api.encoding,
                       headers: api.headers,
                       interceptor: nil,
                       requestModifier: nil).response { response in
                        if let data = response.data {
                            let decoder = AppJSONDecoder<T>()
                            do {
                                let result = try decoder.decode(jsonData: data)
                                completion(.success(result))
                            } catch let error {
                                completion(.failure(error))
                            }
                        } else {
                            completion(.failure(APIError.invalidData))
                        }
                       }
        }
    }
}
