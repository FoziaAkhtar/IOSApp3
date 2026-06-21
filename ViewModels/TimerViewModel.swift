
// ===========================================
// IOSApp3
// TimerViewModel
//
// Purpose:
// Handles all timer logic including:
// start, pause, reset, persistence,
// progress updates, haptics, notifications.
// ===========================================

import SwiftUI
import Combine
import WatchKit

class TimerViewModel: ObservableObject {

    // Published UI state
    @Published var timeRemaining = 0
    @Published var totalTime = 0
    @Published var isRunning = false

    // Internal timer
    private var timer: Timer?

    // UserDefaults key
    private let saveKey = "SavedTimer"

    // Init
    init() {
        loadTimer()
    }

    // Cleanup
    deinit {
        timer?.invalidate()
    }

    // Set timer duration
    func setTimer(seconds: Int) {

        timer?.invalidate()

        totalTime = seconds
        timeRemaining = seconds
        isRunning = false

        saveTimer()
    }

    // Start timer
    func startTimer() {

        guard timeRemaining > 0 else { return }
        guard !isRunning else { return }

        isRunning = true

        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in

            guard let self = self else { return }

            if self.timeRemaining > 0 {

                self.timeRemaining -= 1

                // Final countdown haptic
                if self.timeRemaining <= 10 {
                    WKInterfaceDevice.current().play(.click)
                }

            } else {

                self.completeTimer()
            }

            self.saveTimer()
        }
    }

    // Pause timer
    func pauseTimer() {

        timer?.invalidate()
        timer = nil
        isRunning = false
    }

    // Reset timer
    func resetTimer() {

        timer?.invalidate()
        timer = nil

        timeRemaining = totalTime
        isRunning = false

        saveTimer()
    }

    // MARK: - Completion handler (NEW FIX)
    private func completeTimer() {

        timer?.invalidate()
        timer = nil
        isRunning = false

        WKInterfaceDevice.current().play(.success)

        // schedule notification for REAL duration (not 1 second)
        NotificationManager.shared.scheduleNotification()

        saveTimer()
    }

    // Save state
    func saveTimer() {
        UserDefaults.standard.set(timeRemaining, forKey: saveKey)
    }

    // Load state
    func loadTimer() {

        let savedTime = UserDefaults.standard.integer(forKey: saveKey)

        if savedTime > 0 {
            timeRemaining = savedTime
            totalTime = savedTime
        }
    }

    // Progress (0 → 1)
    var progress: Double {

        guard totalTime > 0 else { return 0 }

        return Double(timeRemaining) / Double(totalTime)
    }
}
