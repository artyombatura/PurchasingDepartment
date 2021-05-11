import Foundation

struct User: Codable {
    let login: String
    let name: String
    let surname: String
    let email: String
    let role: Bool
    let id: Int
    let phone: String
}
