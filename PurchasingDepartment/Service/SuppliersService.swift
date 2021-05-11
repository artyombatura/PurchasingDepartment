import Foundation

protocol SuppliersServiceProtocol {
    func getSuppliers(completion: @escaping ((Result<[Supplier], Error>) -> Void))
}

class SuppliersService: SuppliersServiceProtocol {
    func getSuppliers(completion: @escaping ((Result<[Supplier], Error>) -> Void)) {
        let suppliersAPI = SupplierAPIEndpoint.getAllSuppliers
        APIWorker.shared.request(api: suppliersAPI, [Supplier].self) { result in
            switch result {
            case let .success(suppliers):
                guard let suppliers = suppliers else {
                    completion(.failure(APIError.invalidDecoding))
                    return
                }
                completion(.success(suppliers))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}

class FakeSuppliersService: SuppliersServiceProtocol {
    func getSuppliers(completion: @escaping ((Result<[Supplier], Error>) -> Void)) {
        FakeProductsService().getAllProducts(completion: { result in
            switch result {
            case let .success(products):
                completion(.success([
                    Supplier(id: 1, name: "ООО Кот", email: "kursach@mail.ru", address: "ул. x", phone: "228_1337_422", products: products ?? []),
                    Supplier(id: 2, name: "ООО Кот", email: "kursach@mail.ru", address: "ул. x", phone: "228_1337_422", products: products ?? []),
                    Supplier(id: 3, name: "ООО Кот", email: "kursach@mail.ru", address: "ул. x", phone: "228_1337_422", products: products ?? []),
                    Supplier(id: 4, name: "ООО Кот", email: "kursach@mail.ru", address: "ул. x", phone: "228_1337_422", products: products ?? []),
                    Supplier(id: 5, name: "ООО Кот", email: "kursach@mail.ru", address: "ул. x", phone: "228_1337_422", products: products ?? [])
                ]))
            default:
                completion(.success([]))
            }
        })
    }
}
