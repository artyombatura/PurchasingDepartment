import Foundation

class AppContext {
    let userService: UserServiceProtocol = UserService()
    let ordersService: OrdersServiceProtocol = OrdersService()
    let productsService: ProductsServiceProtocol = ProductsService()
    let suppliersService: SuppliersServiceProtocol = SuppliersService()
    
    let fakeOrdersService: OrdersServiceProtocol = FakeOrdersService()
    let fakeProductsService: ProductsServiceProtocol = FakeProductsService()
    let fakeSuppliersService: SuppliersServiceProtocol = FakeSuppliersService()
}
