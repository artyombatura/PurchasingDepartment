import Foundation

enum JobStatus: String {
    case requested
    case awaitingForPrice
    case inProgress
    case dispute
    case completed
}

extension JobStatus {
    var plainTitle: String {
        switch self {
        case .requested:
            return "Запрошено"
        case .awaitingForPrice:
            return "В ожидании цены"
        case .inProgress:
            return "В процессе"
        case .dispute:
            return "Спор"
        case .completed:
            return "Завершено"
        }
    }
}
