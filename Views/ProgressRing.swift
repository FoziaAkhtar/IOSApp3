
import SwiftUI

// =====================================
// IOSApp3
// ProgressRing
// Purpose:
//  Shows timer progress using a circular
//  ring with dynamic color changes.
// =====================================

struct ProgressRing: View {

    // Current progress (0.0 → 1.0)
    var progress: Double

    // Dynamic color from ViewModel
    var progressColor: Color

    var body: some View {

        ZStack {

            // =====================================================
            // Background Ring (light track)
            // =====================================================
            Circle()
                .stroke(
                    Color.gray.opacity(0.2),
                    lineWidth: 10
                )

            // =====================================================
            // Progress Ring (colored fill)
            // =====================================================
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    progressColor,
                    style: StrokeStyle(
                        lineWidth: 10,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut(duration: 0.5), value: progress)

            // =====================================================
            // Center glow dot (optional visual polish)
            // =====================================================
            Circle()
                .fill(progressColor.opacity(0.15))
                .frame(width: 80, height: 80)
        }
        .frame(width: 130, height: 130)
    }
}
