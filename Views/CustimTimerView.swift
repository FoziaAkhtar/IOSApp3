
// ===========================================
// IOSApp3
// CustomTimerView
// ===========================================
// Purpose:
// Lets user create a custom timer duration.
// ===========================================

import SwiftUI

struct CustomTimerView: View {

    @State private var minutes: String = ""

    var body: some View {

        VStack(spacing: 16) {

            // =====================================================
            // Custom Title (NOT navigation bar title)
            // =====================================================
            Text("Custom Timer")
                .font(.headline)
                .fontWeight(.bold)

            // =====================================================
            // Input Field (minutes)
            // =====================================================
            TextField("Enter minutes", text: $minutes)
                .keyboardType(.numberPad)
                .padding()
                .background(Color.gray.opacity(0.15))
                .cornerRadius(10)

            // =====================================================
            // Start Button
            // =====================================================
            NavigationLink {

                if let mins = Int(minutes) {
                    TimerView(seconds: mins * 60)
                } else {
                    TimerView(seconds: 60)
                }

            } label: {

                Text("Start Timer")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.purple.opacity(0.3))
                    .cornerRadius(10)
            }
        }
        .padding()

        // =====================================================
        // removes top navigation header completely
        // =====================================================
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    CustomTimerView()
}
