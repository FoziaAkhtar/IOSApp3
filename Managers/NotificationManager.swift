
//
// NotificationManager.swift
// iOSApp3
//
// This class manages local notifications.
// A notification is displayed when the timer finishes.
//

import Foundation
import UserNotifications

class NotificationManager {

    // =====================================================
    // Singleton instance
    // Allows one shared notification manager
    // throughout the entire application
    // =====================================================
    static let shared = NotificationManager()

    // Private initializer prevents creation
    // of additional NotificationManager objects
    private init() {
        requestPermission()
    }

    // =====================================================
    // Requests notification permission from the user
    // =====================================================
    func requestPermission() {

        UNUserNotificationCenter.current()
            .requestAuthorization(
                options: [.alert, .sound]
            ) { granted, error in

                if let error = error {
                    print("Notification permission error: \(error.localizedDescription)")
                }

                print("Permission granted: \(granted)")
            }
    }

    // =====================================================
    // Schedules a local notification when the
    // countdown timer has completed
    // =====================================================
    func scheduleNotification() {

        // Create notification content
        let content = UNMutableNotificationContent()

        content.title = "Timer Finished"
        content.body = "Your countdown is complete."
        content.sound = .default

        // Trigger notification after 1 second
        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: 1,
            repeats: false
        )

        // Create notification request
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )

        // Add notification to notification center
        UNUserNotificationCenter.current()
            .add(request) { error in

                if let error = error {
                    print("Notification error: \(error.localizedDescription)")
                }
            }
    }
}
