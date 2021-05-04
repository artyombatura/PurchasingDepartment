import Foundation

protocol ProductsServiceProtocol {
    func getAllProducts(completion: @escaping ((Result<[ProductCatalog], Error>) -> Void))
}

class ProductsService: ProductsServiceProtocol {
    func getAllProducts(completion: @escaping ((Result<[ProductCatalog], Error>) -> Void)) {
        completion(.success([]))
    }
}

class FakeProductsService: ProductsServiceProtocol {
    func getAllProducts(completion: @escaping ((Result<[ProductCatalog], Error>) -> Void)) {
        completion(.success([
            ProductCatalog(name: "Ручка синяя", partNumber: "011_dsa_12", measurementUnit: "Шт."),
            ProductCatalog(name: "Ручка синяя", partNumber: "011_dsa_12", measurementUnit: "Шт."),
            ProductCatalog(name: "Ручка синяя", partNumber: "011_dsa_12", measurementUnit: "Шт."),
            ProductCatalog(name: "Ручка синяя", partNumber: "011_dsa_12", measurementUnit: "Шт."),
            ProductCatalog(name: "Ручка синяя", partNumber: "011_dsa_12", measurementUnit: "Шт."),
            ProductCatalog(name: "Ручка синяя", partNumber: "011_dsa_12", measurementUnit: "Шт."),
            ProductCatalog(name: "Ручка синяя", partNumber: "011_dsa_12", measurementUnit: "Шт."),
            ProductCatalog(name: "Ручка синяя", partNumber: "011_dsa_12", measurementUnit: "Шт."),
            ProductCatalog(name: "Ручка синяя", partNumber: "011_dsa_12", measurementUnit: "Шт.")
        ]))
    }
}
