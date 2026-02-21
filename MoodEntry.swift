import Foundation

struct MoodEntry: Identifiable, Codable {
    var id = UUID()
    var date: Date
    var period: String
    var question: String
    var value: String
}