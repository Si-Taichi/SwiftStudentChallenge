import Foundation
import UserNotifications

class NotificationManager {
    
    static let shared = NotificationManager()
    
    private init() {}
    
    // Request permission
    func requestPermission() {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                
                if granted {
                    print("Notification permission granted")
                } else {
                    print("Notification permission denied")
                }
            }
    }
    
    // Simple test notification (5 seconds)
    func sendTestNotification() {
        
        let content = UNMutableNotificationContent()
        content.title = "Test Notification"
        content.body = "This is a local notification test."
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: 5,
            repeats: false
        )
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error:", error)
            } else {
                print("Test notification scheduled")
            }
        }
    }
}
