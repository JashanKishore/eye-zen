//
//  TimerManager.swift
//  eye-zen
//
//  Created by Jashan kishore on 16/6/2024.
//

import SwiftUI
import UserNotifications

class TimerManager: ObservableObject {
    @Published var isRunning = false
    private var timer: Timer?
    private var timeInterval: TimeInterval = 20 * 60  // 20 minutes in seconds

    func startTimer() {
        isRunning = true
        scheduleNotification()
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false) { _ in
            self.sendNotification()
            self.stopTimer()
        }
    }

    func stopTimer() {
        isRunning = false
        timer?.invalidate()
        timer = nil
    }

    private func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Take a Break"
        content.body = "It's time to take a break from the screen!"
        content.sound = UNNotificationSound.default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request)
    }

    private func sendNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Take a Break"
        content.body = "It's time to take a break from the screen!"
        content.sound = UNNotificationSound.default

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
        UNUserNotificationCenter.current().add(request)
    }
}

