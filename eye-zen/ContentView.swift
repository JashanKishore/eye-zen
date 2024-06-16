//
//  ContentView.swift
//  eye-zen
//
//  Created by Jashan kishore on 16/6/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var timerManager = TimerManager()

    var body: some View {
        VStack {
            Spacer()
            Text(timeString(time: timerManager.remainingTime))
                .font(.largeTitle)
                .padding()
            Button(action: {
                if timerManager.isRunning {
                    timerManager.stopTimer()
                } else {
                    timerManager.startTimer()
                }
            }) {
                Text(timerManager.isRunning ? "Stop" : "Start")
                    .font(.largeTitle)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            Spacer()
        }
        .onAppear {
            UNUserNotificationCenter.current().getNotificationSettings { settings in
                if settings.authorizationStatus != .authorized {
                    print("Notifications not allowed")
                }
            }
        }
    }

    private func timeString(time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
