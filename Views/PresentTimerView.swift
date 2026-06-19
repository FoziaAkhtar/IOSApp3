
import SwiftUI

struct PresetTimerView: View {

    var body: some View {

        // ScrollView allows the list to scroll if content exceeds screen size
        ScrollView {

            // Vertical stack to arrange all preset timer buttons
            VStack(spacing: 12) {

                // Screen title
                Text("Preset Timers")
                    .font(.headline)

                // =====================================================
                // Navigation Link: 1 Minute Timer
                // =====================================================
                NavigationLink("1 Minute") {

                    // Opens TimerView with 60 seconds
                    TimerView(seconds: 60)
                }

                // =====================================================
                // Navigation Link: 5 Minutes Timer
                // =====================================================
                NavigationLink("5 Minutes") {

                    // 5 minutes = 300 seconds
                    TimerView(seconds: 300)
                }

                // =====================================================
                // Navigation Link: 10 Minutes Timer
                // =====================================================
                NavigationLink("10 Minutes") {

                    // 10 minutes = 600 seconds
                    TimerView(seconds: 600)
                }

                // =====================================================
                // Navigation Link: 20 Minutes Timer
                // =====================================================
                NavigationLink("20 Minutes") {

                    // 20 minutes = 1200 seconds
                    TimerView(seconds: 1200)
                }

                // =====================================================
                // Navigation Link: 30 Minutes Timer
                // =====================================================
                NavigationLink("30 Minutes") {

                    // 30 minutes = 1800 seconds
                    TimerView(seconds: 1800)
                }
            }
            .padding() // Adds spacing around content
        }
    }
}

// Preview for Xcode canvas
#Preview {
    PresetTimerView()
}
