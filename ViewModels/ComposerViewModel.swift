import SwiftUI
import Combine

class ComposerViewModel: ObservableObject {
    // Lines of the current form
    @Published var lines: [String]
    
    // Counters (updated in real-time)
    var syllableCounts: [Int] { lines.map { SyllableCounter.countSyllables(in: $0) } }
    
    // Metadata
    @Published var theme: String = ""
    @Published var mood: String = ""
    
    // Form
    @Published var activeForm: PoeticForm
    
    private var cancellables = Set<AnyCancellable>()
    
    init(form: PoeticForm = .haiku) {
        self.activeForm = form
        self.lines = Array(repeating: "", count: form.lineCounts.count)
        setupSyllableCounters()
    }
    
    private func setupSyllableCounters() {
        // Observe form changes to reset lines
        $activeForm
            .sink { [weak self] form in
                DispatchQueue.main.async {
                    self?.lines = Array(repeating: "", count: form.lineCounts.count)
                }
            }
            .store(in: &cancellables)
    }
    
    func updateLine(at index: Int, with text: String) {
        guard index < lines.count else { return }
        lines[index] = text
    }
    
    func lineIsValid(at index: Int) -> Bool {
        guard index < lines.count else { return false }
        return !lines[index].isEmpty && syllableCounts[index] == activeForm.lineCounts[index]
    }
    
    var allLinesValid: Bool {
        lines.indices.allSatisfy { lineIsValid(at: $0) }
    }
    
    func clear() {
        lines = Array(repeating: "", count: activeForm.lineCounts.count)
        theme = ""
        mood = ""
    }
    
    func asHaiku() -> Haiku? {
        guard lines.count >= 3 else { return nil }
        return Haiku(
            line1: lines[0],
            line2: lines[1],
            line3: lines[2],
            theme: theme.isEmpty ? nil : theme,
            mood: mood.isEmpty ? nil : mood
        )
    }
}
