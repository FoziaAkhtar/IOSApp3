
// =========================================
// HomeView.swift
// iOSApp3
// =========================================
// Main menu screen of the app.
// Lets user choose between preset or custom timers.
// =========================================

import SwiftUI

struct HomeView: View {

    var body: some View {

        NavigationStack {

            VStack(spacing: 20) {

                // =====================================================
                // App title (inside UI, not navigation bar)
                // =====================================================
                Text("Watch Timer Pro")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.bottom, 10)

                // =====================================================
                // Navigate to Preset Timers screen
                // =====================================================
                NavigationLink {

                    PresetTimerView()

                } label: {

                    Text("Preset Timers")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(10)
                }

                // =====================================================
                // Navigate to Custom Timer screen
                // =====================================================
                NavigationLink {

                    CustomTimerView()

                } label: {

                    Text("Custom Timer")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green.opacity(0.2))
                        .cornerRadius(10)
                }
            }
            .padding()

            // =====================================================
            // FIX: Navigation bar title changed here
            // =====================================================
            .navigationTitle("Watch Timer")
        }
    }
}
