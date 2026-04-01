import Foundation

struct SyllableCounter {
    /// CMU Pronouncing Dictionary backup
    private static let pronunciationDictionary: [String: [String]] = {
        var dict = [String: [String]]()
        
        guard let url = Bundle.main.url(forResource: "cmudict-0.7b", withExtension: nil),
              let data = try? Data(contentsOf: url),
              let string = String(data: data, encoding: .ascii) else {
            print("Warning: Could not load CMU dictionary, falling back to heuristic")
            return [:]
        }
        
        let lines = string.components(separatedBy: .newlines)
        for line in lines {
            // Skip comments and empty lines
            if line.hasPrefix(";;") || line.isEmpty { continue }
            
            // CMUdict format: word  PRONUNCIATION
            // Some words have multiple pronunciations marked with (1), (2), etc.
            let components = line.components(separatedBy: "  ")
            guard components.count >= 2 else { continue }
            
            let wordPart = components[0]
            let pronunciation = components[1]
            
            // Extract base word (remove trailing (number) if present)
            var baseWord = wordPart
            if let parenRange = baseWord.range(of: #"\(\d+\)"#, options: .regularExpression) {
                baseWord.removeSubrange(parenRange)
            }
            let key = baseWord.lowercased()
            
            // Append pronunciation
            var pronunciations = dict[key] ?? []
            pronunciations.append(pronunciation)
            dict[key] = pronunciations
        }
        
        return dict
    }()
    
    /// Count syllables using CMU dictionary with heuristic fallback
    static func countSyllables(in word: String) -> Int {
        let cleaned = word.lowercased()
            .trimmingCharacters(in: .punctuationCharacters)
            .components(separatedBy: .whitespaces)
            .joined()
        
        if cleaned.isEmpty { return 0 }
        
        // Try dictionary lookup
        if let pronunciations = pronunciationDictionary[cleaned],
           let pronunciation = pronunciations.first { // Use first pronunciation
            // Count syllables: count the numeric stress markers (0,1,2) in pronunciation
            return pronunciation.filter { "012".contains($0) }.count
        }
        
        // Fallback to heuristic for unknown words
        return heuristicSyllableCount(in: cleaned)
    }
    
    /// Improved heuristic syllable counter (used as fallback)
    private static func heuristicSyllableCount(in word: String) -> Int {
        if word.isEmpty { return 0 }
        
        var trimmed = word
        // Remove silent e at end (but not if only one letter or ends with le where consonant before)
        if trimmed.hasSuffix("e") && !trimmed.hasSuffix("le") && trimmed.count > 1 {
            trimmed.removeLast()
        }
        
        let vowels: Set<Character> = ["a", "e", "i", "o", "u", "y"]
        var count = 0
        var previousWasVowel = false
        
        for char in trimmed {
            let isVowel = vowels.contains(char)
            if isVowel && !previousWasVowel {
                count += 1
            }
            previousWasVowel = isVowel
        }
        
        // Ensure at least one syllable if there are letters
        return max(1, count)
    }
    
    /// Count syllables in a full line
    static func countSyllables(in line: String) -> Int {
        let words = line.components(separatedBy: .whitespacesAndNewlines)
        return words.reduce(0) { $0 + countSyllables(in: $1) }
    }
}