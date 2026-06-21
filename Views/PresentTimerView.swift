
// ============================================
//  PresetTimerView.swift
//  iOSApp3
//
//  Purpose:
//  This view provides a list of preset timer options (1, 5, 10, 20, 30 minutes).
//  Each option navigates to the TimerView with a predefined duration in seconds.
// =============================================

import SwiftUI

struct PresetTimerView: View {

    var body: some View {

        // Scrollable container for all preset timer options
        ScrollView {

            // Vertical layout for preset buttons
            VStack(spacing: 12) {

                // Screen title
                Text("Preset Timers")
                    .font(.headline)

                // 1 Minute Timer
                NavigationLink("1 Minute") {
                    TimerView(seconds: 60)
                }

                // 5 Minute Timer
                NavigationLink("5 Minutes") {
                    TimerView(seconds: 300)
                }

                // 10 Minute Timer
                NavigationLink("10 Minutes") {
                    TimerView(seconds: 600)
                }

                // 20 Minute Timer
                NavigationLink("20 Minutes") {
                    TimerView(seconds: 1200)
                }

                // 30 Minute Timer
                NavigationLink("30 Minutes") {
                    TimerView(seconds: 1800)
                }
            }
            .padding()
        }
    }
}

// Preview
#Preview {
    PresetTimerView()
}
