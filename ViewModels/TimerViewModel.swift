
// ===========================================
// TimerViewModel.swift
// iOSApp3
// ===========================================
// Handles all timer functionality:
// - Start timer
// - Pause timer
// - Reset timer
// - Save and load timer state
// - Progress ring updates
// - Watch haptics
// - Completion notifications
// ===========================================

import SwiftUI
import Combine
import WatchKit

class TimerViewModel: ObservableObject {

    // =====================================================
    // Published properties automatically update the UI
    // =====================================================

    // Current countdown value
    @Published var timeRemaining = 0

    // Original timer value
    @Published var totalTime = 0

    // Tracks whether timer is running
    @Published var isRunning = false

    // Internal timer object
    private var timer: Timer?

    // UserDefaults key
    private let saveKey = "SavedTimer"

    // =====================================================
    // Initialization
    // =====================================================
    init() {
        loadTimer()
    }

    // =====================================================
    // Clean up timer when object is removed
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
    // Start countdown
    // =====================================================
    func startTimer() {

        guard timeRemaining > 0 else { return }
        guard !isRunning else { return }

        isRunning = true

        timer = Timer.scheduledTimer(
            withTimeInterval: 1,
            repeats: true
        ) { [weak self] _ in

            guard let self = self else { return }

            if self.timeRemaining > 0 {

                self.timeRemaining -= 1

                // Warning haptic during final 10 seconds
                if self.timeRemaining <= 10 &&
                    self.timeRemaining > 0 {

                    WKInterfaceDevice.current()
                        .play(.click)
                }

            } else {

                self.timer?.invalidate()
                self.timer = nil
                self.isRunning = false

                // Completion haptic
                WKInterfaceDevice.current()
                    .play(.success)

                // Completion notification
                NotificationManager.shared
                    .scheduleNotification()
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
    // Save timer state
    // =====================================================
    func saveTimer() {

        UserDefaults.standard.set(
            timeRemaining,
            forKey: saveKey
        )
    }

    // =====================================================
    // Load timer state
    // =====================================================
    func loadTimer() {

        let savedTime =
            UserDefaults.standard.integer(
                forKey: saveKey
            )

        if savedTime > 0 {

            timeRemaining = savedTime
            totalTime = savedTime
        }
    }

    // =====================================================
    // Progress value for ProgressRing
    // Returns a value between 0.0 and 1.0
    // =====================================================
    var progress: Double {

        guard totalTime > 0 else {
            return 0
        }

        return Double(timeRemaining) /
               Double(totalTime)
    }
}
