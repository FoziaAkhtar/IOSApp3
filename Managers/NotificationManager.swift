
// ===========================================
// IOSApp3
// NotificationManager
//
// Purpose:
// Manages local notifications for the app.
// Triggers an alert when the timer finishes.
// ===========================================

import Foundation
import UserNotifications

class NotificationManager {

    // =====================================================
    // Singleton instance (shared across app)
    // =====================================================
    static let shared = NotificationManager()

    // =====================================================
    // Private initializer (prevents multiple instances)
    // =====================================================
    private init() {
        requestPermission()
    }

    // =====================================================
    // Requests permission for notifications
    // =====================================================
    func requestPermission() {

        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound]) { granted, error in

                if let error = error {
                    print("Notification permission error: \(error.localizedDescription)")
                }

                print("Notification permission granted: \(granted)")
            }
    }

    // =====================================================
    // Schedules a notification when timer finishes
    // =====================================================
    func scheduleNotification(seconds: Int) {

        let content = UNMutableNotificationContent()
        content.title = "Timer Finished"
        content.body = "Your countdown is complete."
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: TimeInterval(seconds),
            repeats: false
        )

        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )

        UNUserNotificationCenter.current().add(request) { error in

            if let error = error {
                print("Notification scheduling error: \(error.localizedDescription)")
            }
        }
    }
}
