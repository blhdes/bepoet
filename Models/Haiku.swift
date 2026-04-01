import Foundation

struct Haiku: Identifiable, Codable {
    let id: UUID
    var line1: String
    var line2: String
    var line3: String
    var timestamp: Date
    var theme: String?
    var mood: String?
    
    init(id: UUID = UUID(), line1: String = "", line2: String = "", line3: String = "", 
         timestamp: Date = Date(), theme: String? = nil, mood: String? = nil) {
        self.id = id
        self.line1 = line1
        self.line2 = line2
        self.line3 = line3
        self.timestamp = timestamp
        self.theme = theme
        self.mood = mood
    }
    
    var lines: [String] {
        [line1, line2, line3]
    }
    
    var isComplete: Bool {
        !line1.isEmpty && !line2.isEmpty && !line3.isEmpty
    }
}