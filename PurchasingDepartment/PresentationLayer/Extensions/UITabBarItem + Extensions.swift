import UIKit

public extension UITabBarItem {
    static let jobsTab = UITabBarItem(title: "Заказы",
                                      image: UIImage.statusesTabIcon,
                                      selectedImage: UIImage.statusesTabIcon)
    
    static let supplierTab = UITabBarItem(title: "Поставщики",
                                      image: UIImage.suppliersTabIcon,
                                      selectedImage: UIImage.suppliersTabIcon)
    
    static let goodsTab = UITabBarItem(title: "Справочник",
                                      image: UIImage.goodsTabIcon,
                                      selectedImage: UIImage.goodsTabIcon)
    
    static let accountTab = UITabBarItem(title: "Аккаунт",
                                      image: UIImage.accountTabIcon,
                                      selectedImage: UIImage.accountTabIcon)
}
