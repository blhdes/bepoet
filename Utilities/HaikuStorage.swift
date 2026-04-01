import Foundation

class HaikuStorage {
    static let shared = HaikuStorage()
    private let userDefaults = UserDefaults.standard
    private let haikuKey = "savedHaikus"
    
    private init() {}
    
    func save(_ haiku: Haiku) {
        var haikus = loadAll()
        haikus.append(haiku)
        save(haikus)
    }
    
    func save(_ haikus: [Haiku]) {
        if let data = try? JSONEncoder().encode(haikus) {
            userDefaults.set(data, forKey: haikuKey)
        }
    }
    
    func loadAll() -> [Haiku] {
        guard let data = userDefaults.data(forKey: haikuKey),
              let haikus = try? JSONDecoder().decode([Haiku].self, from: data) else {
            return []
        }
        return haikus
    }
    
    func delete(at offsets: IndexSet, from haikus: inout [Haiku]) {
        haikus.remove(atOffsets: offsets)
        save(haikus)
    }
    
    func clearAll() {
        userDefaults.removeObject(forKey: haikuKey)
    }
}