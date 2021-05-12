import Foundation

class AppJSONDecoder<T: Decodable> {
    func decode(jsonData data: Data) throws -> T {
        let decoder = JSONDecoder()
        do {
            let model = try decoder.decode(T.self, from: data)
            return model
        } catch {
            throw error
        }
    }
}
