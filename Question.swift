import Foundation

struct Question: Identifiable {
    var id = UUID()
    var text: String
    var options: [QuestionOption]
}

struct QuestionOption: Identifiable {
    var id = UUID()
    var text: String
    var value: String
}