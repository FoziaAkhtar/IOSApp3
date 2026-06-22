
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

        VStack(spacing: 10) {

            Spacer(minLength: 0)

            // =====================================================
            // Progress Ring
            // =====================================================
            ProgressRing(
                progress: timerVM.progress,
                progressColor: timerVM.progressColor
            )
            .frame(width: 110, height: 110)

            // =====================================================
            // Remaining Time
            // =====================================================
            Text(formatTime(timerVM.timeRemaining))
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .foregroundStyle(timerVM.progressColor)
                .padding(.top, 2)

            // =====================================================
            // Controls (FIXED POSITION - closer to ring)
            // =====================================================
            HStack(spacing: 16) {

                Button {
                    timerVM.startTimer()
                } label: {
                    Image(systemName: "play.fill")
                        .font(.system(size: 14, weight: .bold))
                }
                .buttonStyle(.plain)
                .foregroundStyle(.green)

                Button {
                    timerVM.pauseTimer()
                } label: {
                    Image(systemName: "pause.fill")
                        .font(.system(size: 14, weight: .bold))
                }
                .buttonStyle(.plain)
                .foregroundStyle(.orange)

                Button {
                    timerVM.resetTimer()
                } label: {
                    Image(systemName: "arrow.counterclockwise")
                        .font(.system(size: 14, weight: .bold))
                }
                .buttonStyle(.plain)
                .foregroundStyle(.red)
            }
            .padding(.top, 4)

            Spacer(minLength: 0)
        }
        .padding(.horizontal, 6)

        // =====================================================
        // Prevent reset on navigation
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
