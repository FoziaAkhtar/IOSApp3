
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

    // =====================================================
    // Published UI state (updates UI automatically)
    // =====================================================
    @Published var timeRemaining = 0
    @Published var totalTime = 0
    @Published var isRunning = false

    // =====================================================
    // Internal timer reference
    // =====================================================
    private var timer: Timer?

    // =====================================================
    // UserDefaults keys (better separation of values)
    // =====================================================
    private let remainingKey = "SavedRemainingTime"
    private let totalKey = "SavedTotalTime"

    // =====================================================
    // Init: load saved state if available
    // =====================================================
    init() {
        loadTimer()
    }

    // =====================================================
    // Cleanup: stop timer when object is destroyed
    // =====================================================
    deinit {
        timer?.invalidate()
    }

    // =====================================================
    // Set new timer duration
    // =====================================================
    func setTimer(seconds: Int) {

        timer?.invalidate()

        totalTime = seconds
        timeRemaining = seconds
        isRunning = false

        saveTimer()
    }

    // =====================================================
    // Start timer countdown
    // =====================================================
    func startTimer() {

        guard timeRemaining > 0 else { return }
        guard !isRunning else { return }

        isRunning = true

        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in

            guard let self = self else { return }

            // =================================================
            // Prevent negative values + ensure safe completion
            // =================================================
            if self.timeRemaining <= 0 {
                self.completeTimer()
                return
            }

            // =================================================
            // Normal countdown decrement
            // =================================================
            self.timeRemaining -= 1

            // =================================================
            // Final 10 seconds warning haptic (watch only)
            // =================================================
            if self.timeRemaining <= 10 {

                #if os(watchOS)
                WKInterfaceDevice.current().play(.click)
                #endif
            }

            self.saveTimer()
        }
    }

    // =====================================================
    // Pause timer
    // =====================================================
    func pauseTimer() {

        timer?.invalidate()
        timer = nil
        isRunning = false
    }

    // =====================================================
    // Reset timer back to full duration
    // =====================================================
    func resetTimer() {

        timer?.invalidate()
        timer = nil

        timeRemaining = totalTime
        isRunning = false

        saveTimer()
    }

    // =====================================================
    // Handles timer completion logic
    // =====================================================
    private func completeTimer() {

        timer?.invalidate()
        timer = nil
        isRunning = false

        // Completion haptic (watch only safe)
        #if os(watchOS)
        WKInterfaceDevice.current().play(.success)
        #endif

        // Schedule notification for REAL timer duration
        NotificationManager.shared.scheduleNotification(seconds: totalTime)

        saveTimer()
    }

    // =====================================================
    // Save timer state (persistent storage)
    // =====================================================
    func saveTimer() {

        UserDefaults.standard.set(timeRemaining, forKey: remainingKey)
        UserDefaults.standard.set(totalTime, forKey: totalKey)
    }

    // =====================================================
    // Load saved timer state
    // =====================================================
    func loadTimer() {

        let savedRemaining = UserDefaults.standard.integer(forKey: remainingKey)
        let savedTotal = UserDefaults.standard.integer(forKey: totalKey)

        if savedTotal > 0 {
            totalTime = savedTotal
        }

        if savedRemaining > 0 {
            timeRemaining = savedRemaining
        }
    }

    // =====================================================
    // Progress value (0.0 → 1.0)
    // =====================================================
    var progress: Double {

        guard totalTime > 0 else { return 0 }

        return Double(timeRemaining) / Double(totalTime)
    }
}
