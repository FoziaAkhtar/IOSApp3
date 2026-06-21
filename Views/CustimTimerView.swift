
// ==============================================
// CustomTimerView.swift
// iOSApp3
//
// This view allows users to create a custom timer
// by selecting minutes and seconds using pickers.
// ================================================

import SwiftUI

struct CustomTimerView: View {

    // =====================================================
    // State variables store user-selected values
    // They automatically update the UI when changed
    // =====================================================

    // Stores selected minutes (default = 1)
    @State private var minutes = 1

    // Stores selected seconds (default = 0)
    @State private var seconds = 0

    var body: some View {

        VStack(spacing: 20) {

            // Screen title
            Text("Custom Timer")
                .font(.headline)

            // =====================================================
            // Picker for selecting minutes (0 to 59)
            // =====================================================
            Picker("Minutes", selection: $minutes) {

                ForEach(0..<60, id: \.self) { minute in
                    Text("\(minute) Min")
                }
            }
            .pickerStyle(WheelPickerStyle()) // Makes it look like watch/iOS timer style

            // =====================================================
            // Picker for selecting seconds (0 to 59)
            // =====================================================
            Picker("Seconds", selection: $seconds) {

                ForEach(0..<60, id: \.self) { second in
                    Text("\(second) Sec")
                }
            }
            .pickerStyle(WheelPickerStyle())

            // =====================================================
            // Navigation to Timer Screen
            // Passes total time in seconds
            // =====================================================
            NavigationLink {

                TimerView(
                    seconds: (minutes * 60) + seconds
                )

            } label: {

                Text("Set Timer")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}
