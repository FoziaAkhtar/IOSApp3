
// =====================================
// IOSApp3
// ProgressRing
// Purpose:
//  This view displays a circular progress indicator used to visually
//  represent timer progress from 0% to 100%. It shows a background
//  track and a foreground progress arc that updates as the timer runs.
// =====================================
import SwiftUI

struct ProgressRing: View {

    // Current progress value (0.0 = 0%, 1.0 = 100%)
    var progress: Double

    var body: some View {

        // Layers the background ring and progress ring on top of each other
        ZStack {

            // =====================================================
            // Background Ring (Base Track)
            // =====================================================
            // This is the full circle shown as a faint outline.
            // It represents the total progress capacity.
            Circle()
                .stroke(lineWidth: 10)   // Ring thickness
                .opacity(0.2)            // Light gray background

            // =====================================================
            // Progress Ring (Foreground Fill)
            // =====================================================
            // This circle is "trimmed" to show progress.
            // Only a portion of the circle is drawn based on value.
            Circle()
                .trim(from: 0, to: progress) // Controls progress amount (0 → 1)

                .stroke(
                    style: StrokeStyle(
                        lineWidth: 10,       // Matches background thickness
                        lineCap: .round      // Rounded ends for smoother UI
                    )
                )

                // Rotates so progress starts from top (12 o'clock position)
                .rotationEffect(.degrees(-90))

                // Animates changes in progress smoothly
                .animation(.linear, value: progress)
        }

        // Fixed size of the ring
        .frame(width: 120, height: 120)
    }
}

// =====================================================
// Preview (Xcode Canvas)
// =====================================================
#Preview {
    ProgressRing(progress: 0.75)
}
