
// ==============================================
// IOSApp3
// CustomTimerView
//
// Purpose:
// Allows user to create a custom timer
// using minute and second pickers.
// ==============================================

import SwiftUI

struct CustomTimerView: View {

    // Selected minutes
    @State private var minutes = 1

    // Selected seconds
    @State private var seconds = 0

    var body: some View {

        VStack(spacing: 20) {

            // Screen title
            Text("Custom Timer")
                .font(.headline)

            // Minutes picker
            Picker("Minutes", selection: $minutes) {

                ForEach(0..<60, id: \.self) { minute in
                    Text("\(minute) min")
                }
            }
            .pickerStyle(.wheel)

            // Seconds picker
            Picker("Seconds", selection: $seconds) {

                ForEach(0..<60, id: \.self) { second in
                    Text("\(second) sec")
                }
            }
            .pickerStyle(.wheel)

            // Navigate to timer screen
            NavigationLink {

                TimerView(seconds: (minutes * 60) + seconds)

            } label: {

                Text("Set Timer")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(10)
            }
        }
        .padding()
        .navigationTitle("Custom Timer")
    }
}
