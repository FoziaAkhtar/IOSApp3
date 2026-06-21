

// ==========================================
// Purpose:
// Entry point for the Watch App.
// Loads the main screen when the app launches.
// ===========================================
import SwiftUI

@main
struct IOSApp3_Watch_AppApp: App {

    var body: some Scene {

        WindowGroup {

            // Root screen of the watch app
            HomeView()
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
