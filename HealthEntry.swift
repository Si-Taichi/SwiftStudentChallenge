import Foundation

struct HealthEntry: Identifiable, Codable {
    var id = UUID()
    var date: Date
    var bloodSugar: String?
    var bloodPressure: String?
    var bodyFat: String?
    var bmi: Double
}

