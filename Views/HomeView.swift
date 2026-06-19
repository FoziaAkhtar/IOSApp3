
//
// HomeView.swift
// iOSApp3
//
// This is the main menu screen of the app.
// Users can navigate to either:
// 1. Preset timer screen
// 2. Custom timer screen
//

import SwiftUI

struct HomeView: View {

    var body: some View {

        // NavigationStack enables navigation between screens
        NavigationStack {

            // Main vertical layout for menu items
            VStack(spacing: 20) {

                // App title displayed at the top of the screen
                Text("Watch Timer Pro")
                    .font(.title2) // Larger, cleaner title style
                    .fontWeight(.bold) // Makes title stand out
                    .padding(.bottom, 20) // Adds space below title

                // =====================================================
                // Navigation to Preset Timer Screen
                // =====================================================
                NavigationLink {

                    // Destination view when tapped
                    PresetTimerView()

                } label: {

                    // Custom button-style label
                    Text("Preset Timers")
                        .frame(maxWidth: .infinity) // Makes button full width
                        .padding() // Adds internal spacing
                        .background(Color.blue.opacity(0.2)) // Light blue background
                        .cornerRadius(10) // Rounded corners for better UI
                }

                // =====================================================
                // Navigation to Custom Timer Screen
                // =====================================================
                NavigationLink {

                    // Destination view when tapped
                    CustomTimerView()

                } label: {

                    // Custom button-style label
                    Text("Custom Timer")
                        .frame(maxWidth: .infinity) // Full width button
                        .padding() // Internal spacing
                        .background(Color.green.opacity(0.2)) // Light green background
                        .cornerRadius(10) // Rounded corners
                }
            }

            // Adds padding around the whole layout
            .padding()

            // Adds a navigation title at the top of the screen
            .navigationTitle("Home")
        }
    }
}
