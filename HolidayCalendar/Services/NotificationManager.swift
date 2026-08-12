import Foundation
import UserNotifications
import Observation

/// NotificationManager Service
/// Phase 13: Manages UNUserNotificationCenter permissions, Todo reminders, and Holiday alerts
@Observable
final class NotificationManager {
    static let shared = NotificationManager()

    var isAuthorized: Bool = false

    private init() {
        checkAuthorizationStatus()
    }

    /// Checks the current notification authorization status
    func checkAuthorizationStatus() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                self.isAuthorized = (settings.authorizationStatus == .authorized)
            }
        }
    }

    /// Requests notification permissions from the user
    func requestAuthorization(completion: ((Bool) -> Void)? = nil) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            DispatchQueue.main.async {
                self.isAuthorized = granted
                completion?(granted)
            }
        }
    }

    /// Schedules a local notification reminder for a TodoItem
    func scheduleTodoReminder(for todo: TodoItem) {
        guard let reminderDate = todo.reminderDate, reminderDate > Date() else { return }

        let content = UNMutableNotificationContent()
        content.title = todo.title
        content.body = "Priority: \(todo.priority.rawValue) • Task Reminder"
        content.sound = .default

        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: reminderDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)

        let requestID = "todo-\(todo.id.uuidString)"
        let request = UNNotificationRequest(identifier: requestID, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("[NotificationManager] Error scheduling todo reminder: \(error.localizedDescription)")
            }
        }
    }

    /// Cancels a pending notification by identifier
    func cancelNotification(id: String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
    }

    /// Schedules a holiday morning alert (9:00 AM on holiday date)
    func scheduleHolidayAlert(for holiday: Holiday, countryFlag: String, countryName: String) {
        guard holiday.date > Date() else { return }

        var components = Calendar.current.dateComponents([.year, .month, .day], from: holiday.date)
        components.hour = 9
        components.minute = 0

        let content = UNMutableNotificationContent()
        content.title = "\(countryFlag) \(holiday.name)"
        content.body = "Today is a \(holiday.type.rawValue) in \(countryName)!"
        content.sound = .default

        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        let requestID = "holiday-\(holiday.id)"
        let request = UNNotificationRequest(identifier: requestID, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request)
    }
}
