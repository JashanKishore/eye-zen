//
//  eye_zenApp.swift
//  eye-zen
//
//  Created by Jashan kishore on 16/6/2024.
//

import SwiftUI

@main
struct eye_zenApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Request Authorization Failed: \(error)")
            }
        }
        return true
    }
}
