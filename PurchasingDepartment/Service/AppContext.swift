import Foundation

class AppContext {
    struct Constant {
        static let dateFormate = "dd.MM.yyyy"
    }
    
    let alertDispatcher = AlertDispatcher()
    
    let userService: UserServiceProtocol = UserService()
    let ordersService: OrdersServiceProtocol = OrdersService()
    let productsService: ProductsServiceProtocol = ProductsService()
    let suppliersService: SuppliersServiceProtocol = SuppliersService()
    
    let fakeOrdersService: OrdersServiceProtocol = FakeOrdersService()
    let fakeProductsService: ProductsServiceProtocol = FakeProductsService()
    let fakeSuppliersService: SuppliersServiceProtocol = FakeSuppliersService()
}
