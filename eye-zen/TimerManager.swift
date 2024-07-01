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
    @Published var isPaused = false
    @Published var remainingTime: TimeInterval = 0
    @Published var progress: CGFloat = 0.0 // Added for circular progress bar
    private var timer: Timer?
    private var totalTime: TimeInterval {
        return UserDefaults.standard.double(forKey: "notificationInterval") * 60
    }
    
    init() {
            remainingTime = totalTime
        }

    func startTimer() {
        isRunning = true
        isPaused = false
        if remainingTime == 0 {
            remainingTime = totalTime
        }
        scheduleNotification()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if self.remainingTime > 0 {
                self.remainingTime -= 1
                self.updateProgress()
            } else {
                self.sendNotification()
                self.stopTimer()
            }
        }
    }
    
    func pauseTimer() {
            isPaused = true
            timer?.invalidate()
            timer = nil
    }

    func resumeTimer() {
        isPaused = false
        startTimer()
    }

    func stopTimer() {
        isRunning = false
        isPaused = false
        timer?.invalidate()
        timer = nil
        remainingTime = totalTime
        progress = 0.0 // Reset progress
    }
    
    func updateProgress() {
        progress = CGFloat(remainingTime) / CGFloat(totalTime)
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


