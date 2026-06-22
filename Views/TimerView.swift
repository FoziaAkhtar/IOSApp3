
// ================================================
// IOSApp3
// TimerView
// ================================================
// Purpose:
// Displays countdown timer UI with:
// - Progress ring (watch-safe size)
// - Remaining time
// - Start, pause, reset controls
// ================================================

import SwiftUI

struct TimerView: View {

    let seconds: Int

    @StateObject private var timerVM = TimerViewModel()

    var body: some View {

        VStack(spacing: 12) {

            Spacer(minLength: 5)

            // =====================================================
            // Progress Ring (smaller for Watch fit)
            // =====================================================
            ProgressRing(
                progress: timerVM.progress,
                progressColor: timerVM.progressColor
            )
            .frame(width: 120, height: 120)

            // =====================================================
            // Remaining Time
            // =====================================================
            Text(formatTime(timerVM.timeRemaining))
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .foregroundStyle(timerVM.progressColor)
                .minimumScaleFactor(0.7)

            Spacer(minLength: 5)

            // =====================================================
            // Controls (compact Watch layout)
            // =====================================================
            HStack(spacing: 10) {

                Button {
                    timerVM.startTimer()
                } label: {
                    Image(systemName: "play.fill")
                }
                .buttonStyle(.borderedProminent)
                .tint(.green)

                Button {
                    timerVM.pauseTimer()
                } label: {
                    Image(systemName: "pause.fill")
                }
                .buttonStyle(.bordered)
                .tint(.orange)

                Button {
                    timerVM.resetTimer()
                } label: {
                    Image(systemName: "arrow.counterclockwise")
                }
                .buttonStyle(.bordered)
                .tint(.red)
            }
        }
        .padding(.horizontal, 6)
        .padding(.vertical, 8)

        // =====================================================
        // prevent reset on navigation
        // =====================================================
        .onAppear {
            if timerVM.totalTime == 0 {
                timerVM.setTimer(seconds: seconds)
            }
        }
    }

    // =====================================================
    // Format seconds into MM:SS
    // =====================================================
    func formatTime(_ totalSeconds: Int) -> String {
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
