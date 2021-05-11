struct Supplier: Codable {
    let id: Int
    let name: String
    let email: String
    let address: String
    let phone: String
    let products: [ProductCatalog]?
}
