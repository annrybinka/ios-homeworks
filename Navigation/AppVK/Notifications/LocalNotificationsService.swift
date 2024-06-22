import Foundation
import UserNotifications

final class LocalNotificationsService {
    func registerForLatestUpdatesIfPossible() {
        Task {
            try await UNUserNotificationCenter.current().requestAuthorization(
                options: [.badge, .sound, .alert]
            )
        }
    }
    
    private func checkPermission() async -> Bool {
        let settings = await UNUserNotificationCenter.current().notificationSettings()
        return settings.authorizationStatus == .authorized
    }
    
    func createNotificationForLatestUpdates() {
        Task {
            if await checkPermission() {
                let content = UNMutableNotificationContent()
                content.title = "Уведомление"
                content.body = "Посмотрите последние обновления"
                content.sound = .default
                
                let triggerDate = DateComponents(hour: 19, minute: 0)
                let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: true)
                
                let request = UNNotificationRequest(
                    identifier: UUID().uuidString,
                    content: content,
                    trigger: trigger
                )
                try await UNUserNotificationCenter.current().add(request)
                print("wait for 19:00 alert")
            } else {
                print("No notifications permission")
            }
        }
    }
}
