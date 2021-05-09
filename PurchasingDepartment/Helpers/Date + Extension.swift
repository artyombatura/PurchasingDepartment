import Foundation

extension Date {
    func getString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = AppContext.Constant.dateFormate
        return dateFormatter.string(from: self)
    }
}
