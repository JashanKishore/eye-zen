//
//  SettingsView.swift
//  eye-zen
//
//  Created by Jashan kishore on 25/6/2024.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("useCircularCountdown") private var useCircularCountdown = false
    @State private var notificationInterval: Double = 20 // in minutes

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Notifications")) {
                    VStack {
                        Text("Notification Interval")
                        Slider(value: $notificationInterval, in: 5...60, step: 5) {
                            Text("Notification Interval")
                        }
                        .padding()
                        Text("\(Int(notificationInterval)) minutes")
                    }
                }
                Section(header: Text("Countdown Style")) {
                    Toggle(isOn: $useCircularCountdown) {
                        Text("Use Circular Countdown")
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

