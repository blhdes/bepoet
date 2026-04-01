import Foundation

// MARK: - Poetic Form (Progressive Disclosure Foundation)

/// Represents a poetic form with structural constraints.
/// The app starts with haiku and progressively unlocks more complex forms.
struct PoeticForm: Identifiable, Codable, Equatable {
    let id: String
    let name: String
    let subtitle: String
    let lineCounts: [Int]          // Syllable target per line
    let description: String        // Educational description
    let difficulty: Int            // 1-5, used for progressive unlock
    let origin: String             // Cultural/historical context

    var totalLines: Int { lineCounts.count }
    var totalSyllables: Int { lineCounts.reduce(0, +) }

    static let haiku = PoeticForm(
        id: "haiku",
        name: "Haiku",
        subtitle: "5 · 7 · 5",
        lineCounts: [5, 7, 5],
        description: "Three lines observing a single moment. A seasonal reference (kigo) and a cutting word (kireji) create the haiku's resonance.",
        difficulty: 1,
        origin: "Japanese tradition"
    )

    static let tanka = PoeticForm(
        id: "tanka",
        name: "Tanka",
        subtitle: "5 · 7 · 5 · 7 · 7",
        lineCounts: [5, 7, 5, 7, 7],
        description: "Five lines extending the haiku's image with emotional response. The first three lines paint the scene; the last two reflect on it.",
        difficulty: 2,
        origin: "Japanese court poetry"
    )

    static let cinquain = PoeticForm(
        id: "cinquain",
        name: "Cinquain",
        subtitle: "2 · 4 · 6 · 8 · 2",
        lineCounts: [2, 4, 6, 8, 2],
        description: "Five lines building to a climax then collapsing. Named after the American poet Adelaide Crapsey, who studied Japanese forms.",
        difficulty: 3,
        origin: "American, Adelaide Crapsey"
    )

    static let limerick = PoeticForm(
        id: "limerick",
        name: "Limerick",
        subtitle: "8 · 8 · 5 · 5 · 8",
        lineCounts: [8, 8, 5, 5, 8],
        description: "Five lines with an AABBA rhyme scheme. Lively and often humorous, with a distinctive rhythmic bounce.",
        difficulty: 3,
        origin: "English / Irish folk tradition"
    )

    static let sonnet = PoeticForm(
        id: "sonnet",
        name: "Sonnet",
        subtitle: "14 lines · 10 syllables",
        lineCounts: Array(repeating: 10, count: 14),
        description: "Fourteen lines of iambic pentameter. The Shakespearean sonnet follows ABAB CDCD EFEF GG.",
        difficulty: 5,
        origin: "Italian / English tradition"
    )

    static let progressiveForms: [PoeticForm] {
        [haiku, tanka, cinquain, limerick, sonnet].sorted { $0.difficulty < $1.difficulty }
    }
}
