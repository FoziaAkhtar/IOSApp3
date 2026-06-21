
import SwiftUI

// =====================================
// IOSApp3
// ProgressRing
// Purpose:
// Shows a circular progress indicator from 0% to 100%.
// Used to visually display timer progress.
// =====================================

struct ProgressRing: View {

    // Progress value (0.0 = empty, 1.0 = full)
    var progress: Double

    var body: some View {

        ZStack {

            // Background ring (full circle track)
            Circle()
                .stroke(lineWidth: 10)
                .opacity(0.2)

            // Progress ring (filled portion)
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    style: StrokeStyle(
                        lineWidth: 10,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
                .animation(.linear, value: progress)
        }

        // Ring size
        .frame(width: 120, height: 120)
    }
}

// Preview
#Preview {
    ProgressRing(progress: 0.75)
}
