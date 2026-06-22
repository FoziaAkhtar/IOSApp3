
// ==============================================
// IOSApp3
// PresetTimerView
//
// Purpose:
// Shows preset timer options (1, 5, 10, 20, 30 min)
// with a clean, colorful Apple Watch style UI.
// ==============================================

import SwiftUI

struct PresetTimerView: View {

    var body: some View {

        ScrollView {

            VStack(spacing: 12) {

                // =====================================================
                // Screen Title
                // =====================================================
                Text("Preset Timers")
                    .font(.headline)
                    .padding(.bottom, 10)

                // =====================================================
                // 1 Minute Timer (Green)
                // =====================================================
                NavigationLink {

                    TimerView(seconds: 60)

                } label: {

                    presetRow(title: "1 Minute", color: .green)
                }

                // =====================================================
                // 5 Minutes Timer (Blue)
                // =====================================================
                NavigationLink {

                    TimerView(seconds: 300)

                } label: {

                    presetRow(title: "5 Minutes", color: .blue)
                }

                // =====================================================
                // 10 Minutes Timer (Mint)
                // =====================================================
                NavigationLink {

                    TimerView(seconds: 600)

                } label: {

                    presetRow(title: "10 Minutes", color: .mint)
                }

                // =====================================================
                // 20 Minutes Timer (Orange)
                // =====================================================
                NavigationLink {

                    TimerView(seconds: 1200)

                } label: {

                    presetRow(title: "20 Minutes", color: .orange)
                }

                // =====================================================
                // 30 Minutes Timer (Red)
                // =====================================================
                NavigationLink {

                    TimerView(seconds: 1800)

                } label: {

                    presetRow(title: "30 Minutes", color: .red)
                }
            }
            .padding()
        }
    }

    // =====================================================
    // Reusable UI row (clean card style)
    // =====================================================
    @ViewBuilder
    func presetRow(title: String, color: Color) -> some View {

        Text(title)
            .font(.headline)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(color.gradient)
            )
    }
}

#Preview {
    PresetTimerView()
}
