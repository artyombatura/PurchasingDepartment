import Foundation

protocol UserServiceProtocol {
    var user: User? { get set }
    
    var isAuthorized: Bool { get }
    
    func authorize(with user: User)
    func deauthorize()
    
    func authRequest(login: String, password: String, completion: @escaping (Result<User?, Error>) -> Void)
    
    func register(login: String, password: String, name: String, surname: String, email: String, phone: String, completion: @escaping ((Error?) -> Void))
}

class UserService: UserServiceProtocol {
    struct Constants {
        static let isAuthorizedKey = "is_authorized"
        static let loginKey = "user_login"
        static let passwordKey = "user_password"
    }
    
    public var user: User?
    
    public var isAuthorized: Bool {
        guard let isAuthorized = UserDefaultsWrapper.shared.getValue(of: Bool.self, accessKey: Constants.isAuthorizedKey),
              let _ = UserDefaultsWrapper.shared.getValue(of: String.self, accessKey: Constants.loginKey),
              let _ = UserDefaultsWrapper.shared.getValue(of: String.self, accessKey: Constants.passwordKey) else {
            return false
        }
        return isAuthorized
    }
    
    init() {
        guard let isAuthorized = UserDefaultsWrapper.shared.getValue(of: Bool.self, accessKey: Constants.isAuthorizedKey),
              let savedLogin = UserDefaultsWrapper.shared.getValue(of: String.self, accessKey: Constants.loginKey),
              let savedPassword = UserDefaultsWrapper.shared.getValue(of: String.self, accessKey: Constants.passwordKey) else {
            return
        }
        if isAuthorized {
            authRequest(login: savedLogin, password: savedPassword) { [weak self] result in
                switch result {
                case let .success(user):
                    self?.user = user
                default:
                    break
                }
            }
        }
    }
    
    func authorize(with user: User) {
        self.user = user
        UserDefaultsWrapper.shared.setValue(value: true, accessKey: Constants.isAuthorizedKey)
    }
    
    func deauthorize() {
        user = nil
        UserDefaultsWrapper.shared.setValue(value: false, accessKey: Constants.isAuthorizedKey)
        UserDefaultsWrapper.shared.removeObject(by: Constants.loginKey)
        UserDefaultsWrapper.shared.removeObject(by: Constants.passwordKey)
    }
    
    func authRequest(login: String, password: String, completion: @escaping (Result<User?, Error>) -> Void) {
        let authAPI = UserAPIEndpoint.login(login: login, password: password)
        APIWorker.shared.request(api: authAPI, User.self) { result in
            switch result {
            case let .success(user):
                UserDefaultsWrapper.shared.setValue(value: login, accessKey: Constants.loginKey)
                UserDefaultsWrapper.shared.setValue(value: password, accessKey: Constants.passwordKey)
                completion(.success(user))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    func register(login: String, password: String, name: String, surname: String, email: String, phone: String, completion: @escaping ((Error?) -> Void)) {
        let userAPI = UserAPIEndpoint.register(login: login,
                                               password: password,
                                               name: name,
                                               surname: surname,
                                               email: email,
                                               phone: phone)
        APIWorker.shared.postWithoutResponseRequest(api: userAPI) { error in
            completion(error)
        }
    }
}
