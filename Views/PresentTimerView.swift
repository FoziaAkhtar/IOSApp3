
// ============================================
// IOSApp3
// PresetTimerView
//
// Purpose:
// Shows a list of preset timer options.
// Each option navigates to TimerView with a fixed duration.
// ============================================

import SwiftUI

struct PresetTimerView: View {

    var body: some View {

        ScrollView {

            VStack(spacing: 12) {

                // Screen title
                Text("Preset Timers")
                    .font(.headline)

                // 1 Minute
                NavigationLink {
                    TimerView(seconds: 60)
                } label: {
                    Text("1 Minute")
                }

                // 5 Minutes
                NavigationLink {
                    TimerView(seconds: 300)
                } label: {
                    Text("5 Minutes")
                }

                // 10 Minutes
                NavigationLink {
                    TimerView(seconds: 600)
                } label: {
                    Text("10 Minutes")
                }

                // 20 Minutes
                NavigationLink {
                    TimerView(seconds: 1200)
                } label: {
                    Text("20 Minutes")
                }

                // 30 Minutes
                NavigationLink {
                    TimerView(seconds: 1800)
                } label: {
                    Text("30 Minutes")
                }
            }
            .padding()
        }
        .navigationTitle("Preset Timers")
    }
}

#Preview {
    PresetTimerView()
}
