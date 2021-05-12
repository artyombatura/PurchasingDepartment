import Foundation

class AppJSONEncoder<T: Encodable> {
    func encode(object: T) throws -> Data {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(object)
            return data
        } catch let error {
            throw error
        }
    }
}
