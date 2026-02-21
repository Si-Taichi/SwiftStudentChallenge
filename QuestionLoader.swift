import Foundation

class QuestionLoader {
    
    static func loadQuestions() -> [Question] {
        
        guard let url = Bundle.main.url(forResource: "questions", withExtension: "txt"),
              let content = try? String(contentsOf: url, encoding: .utf8) else {
            print("Failed to load questions.txt")
            return []
        }
        
        var questions: [Question] = []
        let blocks = content.components(separatedBy: "#QUESTION")
        
        for block in blocks {
            let lines = block
                .trimmingCharacters(in: .whitespacesAndNewlines)
                .components(separatedBy: "\n")
            
            guard lines.count > 1 else { continue }
            
            let questionText = lines[0]
            var options: [QuestionOption] = []
            
            for line in lines.dropFirst() {
                let parts = line.components(separatedBy: "|")
                if parts.count == 2 {
                    let option = QuestionOption(
                        text: parts[0],
                        value: parts[1]
                    )
                    options.append(option)
                }
            }
            
            let question = Question(text: questionText, options: options)
            questions.append(question)
        }
        
        return questions
    }
}
