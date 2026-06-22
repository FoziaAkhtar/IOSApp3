
import SwiftUI

// =========================================
// HomeView.swift
// iOSApp3
// =========================================
// Main menu screen of the app.
// Lets user choose between preset or custom timers.
// =========================================

struct HomeView: View {

    var body: some View {

        // IMPORTANT:
        // NavigationStack is required for NavigationLink to work
        NavigationStack {

            // =====================================================
            // List is REQUIRED for Apple Watch reliable touch input
            // It ensures full-row tappable navigation behavior
            // =====================================================
            List {

                // =====================================================
                // Navigate to Preset Timers screen
                // =====================================================
                NavigationLink {

                    PresetTimerView()

                } label: {

                    Text("Preset Timers")
                }

                // =====================================================
                // Navigate to Custom Timer screen
                // =====================================================
                NavigationLink {

                    CustomTimerView()

                } label: {

                    Text("Custom Timer")
                }
            }

            // =====================================================
            // Navigation title shown at top of screen
            // =====================================================
            .navigationTitle("Home")
        }
    }
}
