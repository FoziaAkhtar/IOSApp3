
// ================================================
// IOSApp3
// TimerView
//
// Purpose:
// Displays countdown timer UI with:
// - Progress ring
// - Remaining time
// - Start, pause, reset controls
// ================================================

import SwiftUI

struct TimerView: View {

    // Total duration passed from previous screen
    let seconds: Int

    // Timer logic controller
    @StateObject private var timerVM = TimerViewModel()

    var body: some View {

        VStack(spacing: 18) {

            // =====================================================
            // Progress Indicator (NOW COLORED)
            // =====================================================
            ProgressRing(
                progress: timerVM.progress,
                progressColor: timerVM.progressColor
            )

            // =====================================================
            // Remaining Time Display (color matched to ring)
            // =====================================================
            Text(formatTime(timerVM.timeRemaining))
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundStyle(timerVM.progressColor)

            // =====================================================
            // Controls (modern styled buttons)
            // =====================================================
            HStack(spacing: 12) {

                Button {
                    timerVM.startTimer()
                } label: {
                    Label("Start", systemImage: "play.fill")
                }
                .buttonStyle(.borderedProminent)
                .tint(.green)

                Button {
                    timerVM.pauseTimer()
                } label: {
                    Label("Pause", systemImage: "pause.fill")
                }
                .buttonStyle(.bordered)
                .tint(.orange)

                Button {
                    timerVM.resetTimer()
                } label: {
                    Label("Reset", systemImage: "arrow.counterclockwise")
                }
                .buttonStyle(.bordered)
                .tint(.red)
            }
        }
        .padding()

        // =====================================================
        // Set timer only once when screen opens
        // =====================================================
        .onAppear {
            timerVM.setTimer(seconds: seconds)
        }
    }

    // =====================================================
    // Format seconds into MM:SS
    // Example: 90 → 01:30
    // =====================================================
    func formatTime(_ totalSeconds: Int) -> String {

        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60

        return String(format: "%02d:%02d", minutes, seconds)
    }
}

#Preview {
    TimerView(seconds: 60)
}
