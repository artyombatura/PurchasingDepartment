import Foundation

protocol SuppliersServiceProtocol {
    func getSuppliers(completion: @escaping ((Result<[Supplier], Error>) -> Void))
}

class SuppliersService: SuppliersServiceProtocol {
    func getSuppliers(completion: @escaping ((Result<[Supplier], Error>) -> Void)) {
        completion(.success([]))
    }
}

class FakeSuppliersService: SuppliersServiceProtocol {
    func getSuppliers(completion: @escaping ((Result<[Supplier], Error>) -> Void)) {
        FakeProductsService().getAllProducts(completion: { result in
            switch result {
            case let .success(products):
                completion(.success([
                    Supplier(id: "1", name: "ООО Кот в говне", email: "govno_kursach@mail.ru", address: "ул. Хуй", phone: "228_1337_422", products: products),
                    Supplier(id: "2", name: "ООО Кот в говне", email: "govno_kursach@mail.ru", address: "ул. Хуй", phone: "228_1337_422", products: products),
                    Supplier(id: "3", name: "ООО Кот в говне", email: "govno_kursach@mail.ru", address: "ул. Хуй", phone: "228_1337_422", products: products),
                    Supplier(id: "4", name: "ООО Кот в говне", email: "govno_kursach@mail.ru", address: "ул. Хуй", phone: "228_1337_422", products: products),
                    Supplier(id: "5", name: "ООО Кот в говне", email: "govno_kursach@mail.ru", address: "ул. Хуй", phone: "228_1337_422", products: products)
                ]))
            default:
                completion(.success([]))
            }
        })
    }
}
