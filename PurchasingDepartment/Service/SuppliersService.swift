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
        completion(.success([
            Supplier(name: "ООО Кот в говне", email: "govno_kursach@mail.ru", address: "ул. Хуй", phone: "228_1337_422"),
            Supplier(name: "ООО Кот в говне", email: "govno_kursach@mail.ru", address: "ул. Хуй", phone: "228_1337_422"),
            Supplier(name: "ООО Кот в говне", email: "govno_kursach@mail.ru", address: "ул. Хуй", phone: "228_1337_422"),
            Supplier(name: "ООО Кот в говне", email: "govno_kursach@mail.ru", address: "ул. Хуй", phone: "228_1337_422"),
            Supplier(name: "ООО Кот в говне", email: "govno_kursach@mail.ru", address: "ул. Хуй", phone: "228_1337_422"),
            Supplier(name: "ООО Кот в говне", email: "govno_kursach@mail.ru", address: "ул. Хуй", phone: "228_1337_422"),
            Supplier(name: "ООО Кот в говне", email: "govno_kursach@mail.ru", address: "ул. Хуй", phone: "228_1337_422"),
            Supplier(name: "ООО Кот в говне", email: "govno_kursach@mail.ru", address: "ул. Хуй", phone: "228_1337_422"),
            Supplier(name: "ООО Кот в говне", email: "govno_kursach@mail.ru", address: "ул. Хуй", phone: "228_1337_422"),
            Supplier(name: "ООО Кот в говне", email: "govno_kursach@mail.ru", address: "ул. Хуй", phone: "228_1337_422"),
            Supplier(name: "ООО Кот в говне", email: "govno_kursach@mail.ru", address: "ул. Хуй", phone: "228_1337_422"),
            Supplier(name: "ООО Кот в говне", email: "govno_kursach@mail.ru", address: "ул. Хуй", phone: "228_1337_422")
        ]))
    }
}
