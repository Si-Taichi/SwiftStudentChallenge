import Foundation

enum CheckInPeriod: String {
    case morning
    case afternoon
    case evening
    
    static func current() -> CheckInPeriod? {
        let hour = Calendar.current.component(.hour, from: Date())
        
        switch hour {
        case 5..<12:
            return .morning
        case 12..<18:
            return .afternoon
        case 18..<24:
            return .evening
        default:
            return nil
        }
    }
}