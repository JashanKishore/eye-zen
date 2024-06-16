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
    @Published var remainingTime: TimeInterval = 10 // testing
    private var timer: Timer?
    private var totalTime: TimeInterval = 10 // testing

    func startTimer() {
        isRunning = true
        remainingTime = totalTime
        scheduleNotification()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if self.remainingTime > 0 {
                self.remainingTime -= 1
            } else {
                self.sendNotification()
                self.stopTimer()
            }
        }
    }

    func stopTimer() {
        isRunning = false
        timer?.invalidate()
        timer = nil
        remainingTime = totalTime
    }

    private func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Take a Break"
        content.body = "It's time to take a break from the screen!"
        content.sound = UNNotificationSound.default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: totalTime, repeats: false)
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


