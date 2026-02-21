import Foundation

class HealthEntryManager {
    
    static let shared = HealthEntryManager()
    private let key = "healthEntries"
    
    func saveEntry(_ entry: HealthEntry) {
        var entries = loadEntries()
        entries.insert(entry, at: 0)
        
        if let encoded = try? JSONEncoder().encode(entries) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    
    func loadEntries() -> [HealthEntry] {
        guard let data = UserDefaults.standard.data(forKey: key),
              let decoded = try? JSONDecoder().decode([HealthEntry].self, from: data)
        else {
            return []
        }
        return decoded
    }
}

