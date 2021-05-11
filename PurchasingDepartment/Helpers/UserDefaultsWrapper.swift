import Foundation

class UserDefaultsWrapper {
    
    static let shared = UserDefaultsWrapper()
    
    private init() { }
    
    func getValue<T>(of type: T.Type, accessKey: String) -> T? {
        return UserDefaults.standard.object(forKey: accessKey) as? T
    }
    
    func setValue(value: Any, accessKey: String) {
        UserDefaults.standard.setValue(value, forKey: accessKey)
    }
    
    func removeObject(by key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
