
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
            // List ensures proper touch interaction on Apple Watch
            // and makes navigation fully tappable
            // =====================================================
            List {

                // =====================================================
                // Navigate to Preset Timers screen
                // =====================================================
                NavigationLink {

                    PresetTimerView()

                } label: {

                    Text("Preset Timers")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            LinearGradient(
                                colors: [.blue, .cyan],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .cornerRadius(12)
                }

                // =====================================================
                // Navigate to Custom Timer screen
                // =====================================================
                NavigationLink {

                    CustomTimerView()

                } label: {

                    Text("Custom Timer")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            LinearGradient(
                                colors: [.green, .mint],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .cornerRadius(12)
                }
            }

            // =====================================================
            // Navigation title shown at top of screen
            // =====================================================
            .navigationTitle("Home")
        }
    }
}
