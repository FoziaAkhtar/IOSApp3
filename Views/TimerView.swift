
// ================================================
// IOSApp3
// TimerView
// ================================================
// Purpose:
// Displays countdown timer UI with:
// - Progress ring
// - Remaining time
// - Start, pause, reset controls
// ================================================

import SwiftUI

struct TimerView: View {

    let seconds: Int

    @StateObject private var timerVM = TimerViewModel()

    var body: some View {

        VStack(spacing: 18) {

            // =====================================================
            // Progress Ring (with color)
            // =====================================================
            ProgressRing(
                progress: timerVM.progress,
                progressColor: timerVM.progressColor
            )

            // =====================================================
            // Remaining Time
            // =====================================================
            Text(formatTime(timerVM.timeRemaining))
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundStyle(timerVM.progressColor)

            // =====================================================
            // Controls
            // =====================================================
            HStack(spacing: 12) {

                Button("Start") {
                    timerVM.startTimer()
                }
                .buttonStyle(.borderedProminent)
                .tint(.green)

                Button("Pause") {
                    timerVM.pauseTimer()
                }
                .buttonStyle(.bordered)
                .tint(.orange)

                Button("Reset") {
                    timerVM.resetTimer()
                }
                .buttonStyle(.bordered)
                .tint(.red)
            }
        }
        .padding()

        // =====================================================
        // FIX: Prevent timer reset every navigation
        // =====================================================
        .onAppear {
            if timerVM.totalTime == 0 {
                timerVM.setTimer(seconds: seconds)
            }
        }
    }

    func formatTime(_ totalSeconds: Int) -> String {
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
