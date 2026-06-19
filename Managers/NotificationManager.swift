
//
// NotificationManager.swift
// iOSApp3
//
// This class handles local notifications.
// It is used to notify the user when a timer finishes.
//

import Foundation
import UserNotifications

class NotificationManager {

    // Shared instance (Singleton pattern)
    // This allows the app to use one global notification manager
    static let shared = NotificationManager()

    // Initializer runs once when the shared instance is first used
    init() {
        requestPermission()
    }

    // =====================================================
    // Requests permission from the user to send notifications
    // =====================================================
    func requestPermission() {

        UNUserNotificationCenter.current()
            .requestAuthorization(
                options: [.alert, .sound] // Permission types needed
            ) { granted, error in
                // Currently ignoring response, but can be handled if needed
            }
    }

    // =====================================================
    // Schedules a local notification when timer completes
    // =====================================================
    func scheduleNotification() {

        // Content of the notification
        let content = UNMutableNotificationContent()
        content.title = "Timer Finished" // Notification title
        content.body = "Your countdown is complete." // Message shown
        content.sound = .default // Plays default notification sound

        // Trigger after a short delay (1 second)
        // In real timer app, this would match timer duration
        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: 1,
            repeats: false
        )

        // Create notification request with unique ID
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )

        // Add notification request to system queue
        UNUserNotificationCenter.current()
            .add(request)
    }
}
