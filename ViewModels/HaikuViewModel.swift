import SwiftUI
import Combine

class HaikuViewModel: ObservableObject {
    @Published var line1: String = ""
    @Published var line2: String = ""
    @Published var line3: String = ""
    @Published var theme: String = ""
    @Published var mood: String = ""
    
    @Published var line1SyllableCount: Int = 0
    @Published var line2SyllableCount: Int = 0
    @Published var line3SyllableCount: Int = 0
    
    @Published var line1Valid: Bool = false
    @Published var line2Valid: Bool = false
    @Published var line3Valid: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    let targetCounts = [5, 7, 5]
    
    init() {
        setupSyllableCounting()
    }
    
    private func setupSyllableCounting() {
        let line1Publisher = $line1
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .map { SyllableCounter.countSyllables(in: $0) }
        
        let line2Publisher = $line2
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .map { SyllableCounter.countSyllables(in: $0) }
        
        let line3Publisher = $line3
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .map { SyllableCounter.countSyllables(in: $0) }
        
        line1Publisher
            .assign(to: \.line1SyllableCount, on: self)
            .store(in: &cancellables)
        
        line2Publisher
            .assign(to: \.line2SyllableCount, on: self)
            .store(in: &cancellables)
        
        line3Publisher
            .assign(to: \.line3SyllableCount, on: self)
            .store(in: &cancellables)
        
        // Update validity
        line1Publisher
            .map { $0 == self.targetCounts[0] }
            .assign(to: \.line1Valid, on: self)
            .store(in: &cancellables)
        
        line2Publisher
            .map { $0 == self.targetCounts[1] }
            .assign(to: \.line2Valid, on: self)
            .store(in: &cancellables)
        
        line3Publisher
            .map { $0 == self.targetCounts[2] }
            .assign(to: \.line3Valid, on: self)
            .store(in: &cancellables)
    }
    
    var isHaikuComplete: Bool {
        line1Valid && line2Valid && line3Valid
    }
    
    func saveHaiku() -> Haiku {
        let haiku = Haiku(line1: line1, line2: line2, line3: line3,
                          theme: theme.isEmpty ? nil : theme,
                          mood: mood.isEmpty ? nil : mood)
        return haiku
    }
    
    func clear() {
        line1 = ""
        line2 = ""
        line3 = ""
        theme = ""
        mood = ""
    }
}