
//
// TimerView.swift
// iOSApp3
//
// This view displays the countdown timer UI.
// It shows a progress ring, remaining time,
// and controls to start, pause, and reset the timer.
//

import SwiftUI

struct TimerView: View {

    // Total time passed into this view (in seconds)
    let seconds: Int

    // ViewModel that handles all timer logic (countdown, progress, state)
    @StateObject private var timerVM = TimerViewModel()

    var body: some View {

        VStack(spacing: 15) {

            // =====================================================
            // Visual progress indicator (circular ring)
            // Shows how much time is remaining
            // =====================================================
            ProgressRing(progress: timerVM.progress)

            // =====================================================
            // Remaining time display in MM:SS format
            // =====================================================
            Text(formatTime(timerVM.timeRemaining))
                .font(.title2)
                .bold()

            // =====================================================
            // Timer control buttons (Start / Pause)
            // =====================================================
            HStack {

                // Starts or resumes the timer
                Button("Start") {
                    timerVM.startTimer()
                }

                // Pauses the timer without resetting progress
                Button("Pause") {
                    timerVM.pauseTimer()
                }
            }

            // =====================================================
            // Reset button (resets timer to original value)
            // =====================================================
            Button("Reset") {
                timerVM.resetTimer()
            }
        }

        .padding()

        // =====================================================
        // Initializes timer when screen appears
        // Passes selected duration from previous screen
        // =====================================================
        .onAppear {
            timerVM.setTimer(seconds: seconds)
        }
    }

    // =====================================================
    // Helper function: converts seconds → MM:SS format
    // Example: 90 → 01:30
    // =====================================================
    func formatTime(_ totalSeconds: Int) -> String {

        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60

        return String(
            format: "%02d:%02d",
            minutes,
            seconds
        )
    }
}
