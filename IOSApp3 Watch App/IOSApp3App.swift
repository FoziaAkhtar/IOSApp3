
//
//  IOSApp3App.swift
//  IOSApp3 Watch App
//
//  Created by Fozia on 2026-06-19.
//
//  This is the entry point of the application.
//  The app starts by loading the HomeView screen.
//

import SwiftUI

@main
struct IOSApp3_Watch_AppApp: App {

    var body: some Scene {

        WindowGroup {

            // Opens the main menu screen when the app launches.
            HomeView()
        }
    }
}
