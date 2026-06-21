
// ==============================================
// IOSApp3
// NotificationManager
//
// Purpose:
// Manages local notifications for the app.
// Sends a notification when the timer finishes.
// ==============================================

import Foundation
import UserNotifications

class NotificationManager {

    // Shared instance (Singleton)
    static let shared = NotificationManager()

    // Private initializer (prevents multiple instances)
    private init() {
        requestPermission()
    }

    // Request permission for notifications
    func requestPermission() {

        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound]) { granted, error in

                if let error = error {
                    print("Notification error: \(error.localizedDescription)")
                }

                print("Notification permission granted: \(granted)")
            }
    }

    // Schedule notification when timer ends
    func scheduleNotification() {

        let content = UNMutableNotificationContent()
        content.title = "Timer Finished"
        content.body = "Your countdown is complete."
        content.sound = .default

        // Trigger after short delay (for demo/testing)
        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: 1,
            repeats: false
        )

        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )

        UNUserNotificationCenter.current()
            .add(request) { error in

                if let error = error {
                    print("Failed to schedule notification: \(error.localizedDescription)")
                }
            }
    }
}
