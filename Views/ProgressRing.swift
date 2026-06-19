
//
// ProgressRing.swift
// iOSApp3
//
// This view displays a circular progress indicator.
// It is used to visually show timer completion progress.
//

import SwiftUI

struct ProgressRing: View {

    // Progress value between 0.0 (0%) and 1.0 (100%)
    var progress: Double

    var body: some View {

        // ZStack layers shapes on top of each other
        ZStack {

            // =====================================================
            // Background circle (full ring outline)
            // =====================================================
            Circle()
                .stroke(lineWidth: 10) // Thickness of ring
                .opacity(0.2) // Light grey background ring

            // =====================================================
            // Foreground progress circle (animated fill)
            // =====================================================
            Circle()
                // Controls how much of the circle is shown
                .trim(from: 0, to: progress)

                .stroke(
                    style: StrokeStyle(
                        lineWidth: 10, // Same thickness as background
                        lineCap: .round // Rounded ends for smoother look
                    )
                )

                // Rotates so progress starts from top (12 o'clock)
                .rotationEffect(.degrees(-90))

                // Smooth animation when progress changes
                .animation(.linear, value: progress)
        }

        // Fixed size of the progress ring
        .frame(width: 120, height: 120)
    }
}

// Preview for Xcode canvas
#Preview {
    ProgressRing(progress: 0.75)
}
