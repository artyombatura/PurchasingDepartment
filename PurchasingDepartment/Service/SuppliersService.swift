import Foundation

protocol SuppliersServiceProtocol {
    func getSuppliers(completion: @escaping ((Result<[Supplier], Error>) -> Void))
    
    func getSupplier(id: Int, completion: @escaping ((Result<Supplier?, Error>) -> Void))
    
    func registerSupplier(name: String, email: String, address: String, phone: String, completion: @escaping ((Error?) -> Void))
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
    
    func getSupplier(id: Int, completion: @escaping ((Result<Supplier?, Error>) -> Void)) {
        let api = SupplierAPIEndpoint.getSupplier(id: id)
        APIWorker.shared.request(api: api, Supplier.self) { result in
            completion(result)
        }
    }
    
    func registerSupplier(name: String, email: String, address: String, phone: String, completion: @escaping ((Error?) -> Void)) {
        let registerSupplierEndpoint = SupplierAPIEndpoint.registerSupplier(name: name,
                                                                            email: email,
                                                                            address: address,
                                                                            phone: phone)
        APIWorker.shared.postWithoutResponseRequest(api: registerSupplierEndpoint) { error in
            completion(error)
        }
    }
}

class FakeSuppliersService: SuppliersServiceProtocol {
    func getSuppliers(completion: @escaping ((Result<[Supplier], Error>) -> Void)) {
        FakeProductsService().getAllProducts(completion: { result in
            switch result {
            case let .success(products):
                completion(.success([
                    Supplier(id: 1, name: "ООО Поставщик Тест 1", email: "kursach@mail.ru", address: "ул. x", phone: "228_1337_422", products: products ?? []),
                    Supplier(id: 2, name: "ООО Поставщик Тест 2", email: "kursach@mail.ru", address: "ул. x", phone: "228_1337_422", products: products ?? []),
                    Supplier(id: 3, name: "ООО Поставщик Тест 3", email: "kursach@mail.ru", address: "ул. x", phone: "228_1337_422", products: products ?? []),
                    Supplier(id: 4, name: "ООО Поставщик Тест 4", email: "kursach@mail.ru", address: "ул. x", phone: "228_1337_422", products: products ?? []),
                    Supplier(id: 5, name: "ООО Поставщик Тест 5", email: "kursach@mail.ru", address: "ул. x", phone: "228_1337_422", products: products ?? [])
                ]))
            default:
                completion(.success([]))
            }
        })
    }
    
    func getSupplier(id: Int, completion: @escaping ((Result<Supplier?, Error>) -> Void)) { }
    
    func registerSupplier(name: String, email: String, address: String, phone: String, completion: @escaping ((Error?) -> Void)) { }
}
