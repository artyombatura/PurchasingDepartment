import Foundation

protocol UserServiceProtocol {
    var user: User? { get set }
    
    var isAuthorized: Bool { get }
    
    func authorize()
    func deauthorize()
}

class UserService: UserServiceProtocol {
    struct Constants {
        static let isAuthorizedKey = "is_authorized"
    }
    
    public var user: User?
    
    public var isAuthorized: Bool {
        return UserDefaultsWrapper.shared.getValue(of: Bool.self, accessKey: Constants.isAuthorizedKey) ?? false
    }
    
    init() { }
    
    func authorize() {
        UserDefaultsWrapper.shared.setValue(value: true, accessKey: Constants.isAuthorizedKey)
    }
    
    func deauthorize() {
        UserDefaultsWrapper.shared.setValue(value: false, accessKey: Constants.isAuthorizedKey)
    }
}
