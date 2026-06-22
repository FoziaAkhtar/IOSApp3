
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

        NavigationStack {

            VStack(spacing: 20) {

                // =====================================================
                // App title (custom UI title instead of navigation bar)
                // =====================================================
                Text("Watch Timer")
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
            // hides navigation bar title completely
            // =====================================================
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(.hidden, for: .navigationBar)
        }
    }
}
