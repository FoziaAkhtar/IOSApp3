
// ===========================================
// IOSApp3
// TimerViewModel
// ===========================================
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
    // Published UI state (auto-updates UI)
    // =====================================================
    @Published var timeRemaining = 0
    @Published var totalTime = 0
    @Published var isRunning = false

    // =====================================================
    // Internal timer reference
    // =====================================================
    private var timer: Timer?

    // =====================================================
    // UserDefaults keys
    // =====================================================
    private let remainingKey = "SavedRemainingTime"
    private let totalKey = "SavedTotalTime"

    // =====================================================
    // Init: load saved timer state
    // =====================================================
    init() {
        loadTimer()
    }

    // =====================================================
    // Cleanup
    // =====================================================
    deinit {
        timer?.invalidate()
    }

    // =====================================================
    // Set timer duration
    // =====================================================
    func setTimer(seconds: Int) {

        timer?.invalidate()

        totalTime = seconds
        timeRemaining = seconds
        isRunning = false

        saveTimer()
    }

    // =====================================================
    // Start timer
    // =====================================================
    func startTimer() {

        guard timeRemaining > 0 else { return }
        guard !isRunning else { return }

        isRunning = true

        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in

            guard let self = self else { return }

            // =================================================
            // Handle completion safely
            // =================================================
            if self.timeRemaining <= 0 {
                self.completeTimer()
                return
            }

            // =================================================
            // Countdown step
            // =================================================
            self.timeRemaining -= 1

            // =================================================
            // Warning haptic (Watch only)
            // =================================================
            if self.timeRemaining <= 10 && self.timeRemaining > 0 {

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
    // Reset timer
    // =====================================================
    func resetTimer() {

        timer?.invalidate()
        timer = nil

        timeRemaining = totalTime
        isRunning = false

        saveTimer()
    }

    // =====================================================
    // Completion handler
    // =====================================================
    private func completeTimer() {

        timer?.invalidate()
        timer = nil
        isRunning = false

        // Watch haptic
        #if os(watchOS)
        WKInterfaceDevice.current().play(.success)
        #endif

        // matches NotificationManager(seconds:)
        NotificationManager.shared.scheduleNotification(seconds: totalTime)

        saveTimer()
    }

    // =====================================================
    // Save state
    // =====================================================
    func saveTimer() {

        UserDefaults.standard.set(timeRemaining, forKey: remainingKey)
        UserDefaults.standard.set(totalTime, forKey: totalKey)
    }

    // =====================================================
    // Load state
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
    // Progress (0 → 1)
    // =====================================================
    var progress: Double {

        guard totalTime > 0 else { return 0 }

        return Double(max(timeRemaining, 0)) / Double(totalTime)
    }
}
