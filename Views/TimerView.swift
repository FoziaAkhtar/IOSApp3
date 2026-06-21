
// ================================================
// TimerView.swift
// iOSApp3
//
// This view displays the countdown timer UI.
// It shows a progress ring, remaining time,
// and controls to start, pause, and reset the timer.
// =================================================

import SwiftUI

struct TimerView: View {

    // Total time passed into this view (in seconds)
    let seconds: Int

    // ViewModel that handles all timer logic
    @StateObject private var timerVM = TimerViewModel()

    var body: some View {

        ScrollView {

            VStack(spacing: 10) {

                // =====================================================
                // Visual progress indicator
                // =====================================================
                ProgressRing(
                    progress: timerVM.progress
                )

                // =====================================================
                // Remaining time display
                // =====================================================
                Text(formatTime(timerVM.timeRemaining))
                    .font(.headline)
                    .bold()

                // =====================================================
                // Start Button
                // =====================================================
                Button {

                    timerVM.startTimer()

                } label: {

                    Label("Start", systemImage: "play.fill")
                }

                // =====================================================
                // Pause Button
                // =====================================================
                Button {

                    timerVM.pauseTimer()

                } label: {

                    Label("Pause", systemImage: "pause.fill")
                }

                // =====================================================
                // Reset Button
                // =====================================================
                Button {

                    timerVM.resetTimer()

                } label: {

                    Label("Reset", systemImage: "arrow.counterclockwise")
                }
            }
            .padding()
        }

        // =====================================================
        // Initialize timer when view appears
        // =====================================================
        .onAppear {

            timerVM.setTimer(seconds: seconds)
        }
    }

    // =====================================================
    // Converts seconds into MM:SS format
    // Example: 90 -> 01:30
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

#Preview {
    TimerView(seconds: 60)
}
