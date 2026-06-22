
// =====================================
// IOSApp3
// ProgressRing
// Purpose:
//  Shows timer progress using a circular
//  ring with dynamic color changes.
// =====================================

import SwiftUI

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
                    lineWidth: 8   // FIX: thinner for Watch fit
                )

            // =====================================================
            // Progress Ring (colored fill)
            // =====================================================
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    progressColor,
                    style: StrokeStyle(
                        lineWidth: 8,     // FIX: matches background
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut(duration: 0.4), value: progress)

            // =====================================================
            // Center Dot (simplified glow)
            // =====================================================
            Circle()
                .fill(progressColor.opacity(0.12))
                .frame(width: 60, height: 60)   // FIX: smaller & cleaner
        }

        // FIX: smaller overall size for Watch UI
        .frame(width: 110, height: 110)
    }
}
