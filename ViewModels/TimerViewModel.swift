
//
// TimerViewModel.swift
// iOSApp3
//
// Handles all timer logic including:
// start, pause, reset, persistence, progress updates,
// notifications, and Watch haptics.
//

import SwiftUI
import Combine
import WatchKit

class TimerViewModel: ObservableObject {

    // =====================================================
    // UI-UPDATED VALUES
    // =====================================================

    // Current countdown time (seconds remaining)
    @Published var timeRemaining = 0

    // Original starting time (used for reset + progress)
    @Published var totalTime = 0

    // Tracks whether timer is currently running
    @Published var isRunning = false

    // Internal Timer object
    private var timer: Timer?

    // Key for saving data in UserDefaults
    private let saveKey = "SavedTimer"

    // =====================================================
    // INITIALIZATION
    // =====================================================
    init() {
        loadTimer()
    }

    // =====================================================
    // SET TIMER VALUE
    // =====================================================
    func setTimer(seconds: Int) {
        totalTime = seconds
        timeRemaining = seconds
        saveTimer()
    }

    // =====================================================
    // START TIMER
    // =====================================================
    func startTimer() {

        guard timeRemaining > 0 else { return }
        guard isRunning == false else { return }

        isRunning = true

        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in

            if self.timeRemaining > 0 {

                self.timeRemaining -= 1

                // Warning haptic in last 10 seconds
                if self.timeRemaining <= 10 {
                    WKInterfaceDevice.current().play(.click)
                }

            } else {

                self.timer?.invalidate()
                self.timer = nil
                self.isRunning = false

                WKInterfaceDevice.current().play(.success)

                NotificationManager.shared.scheduleNotification()
            }

            self.saveTimer()
        }
    }

    // =====================================================
    // PAUSE TIMER
    // =====================================================
    func pauseTimer() {
        timer?.invalidate()
        timer = nil
        isRunning = false
    }

    // =====================================================
    // RESET TIMER
    // =====================================================
    func resetTimer() {
        timer?.invalidate()
        timer = nil
        timeRemaining = totalTime
        isRunning = false
        saveTimer()
    }

    // =====================================================
    // SAVE TIMER
    // =====================================================
    func saveTimer() {
        UserDefaults.standard.set(timeRemaining, forKey: saveKey)
    }

    // =====================================================
    // LOAD TIMER
    // =====================================================
    func loadTimer() {
        let saved = UserDefaults.standard.integer(forKey: saveKey)

        if saved > 0 {
            timeRemaining = saved
            totalTime = saved
        }
    }

    // =====================================================
    // PROGRESS (0.0 → 1.0)
    // =====================================================
    var progress: Double {
        guard totalTime > 0 else { return 0 }
        return Double(timeRemaining) / Double(totalTime)
    }
}
