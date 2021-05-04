import Foundation

struct Order {
    let name = "Ручка"
    let partNumber = "00031_dsaa"
    let requestNumber: Int
    let date: Date
    let status: JobStatus
    let totalPrice: Double
    let note: String
}
