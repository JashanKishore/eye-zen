//
//  ContentView.swift
//  eye-zen
//
//  Created by Jashan kishore on 16/6/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var timerManager = TimerManager()
    @State private var showAlert = false

    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Text(timeString(time: timerManager.remainingTime))
                    .font(.largeTitle)
                    .padding(.bottom, 50)

                VStack(spacing: 20) {
                    Button(action: {
                        withAnimation {
                            if timerManager.isRunning {
                                if timerManager.isPaused {
                                    timerManager.resumeTimer()
                                } else {
                                    timerManager.pauseTimer()
                                }
                            } else {
                                timerManager.startTimer()
                            }
                        }
                    }) {
                        Text(timerManager.isRunning ? (timerManager.isPaused ? "Resume" : "Pause") : "Start")
                            .font(.largeTitle)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }

                    Button(action: {
                        withAnimation {
                            showAlert = true
                        }
                    }) {
                        Text("End")
                            .font(.title)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .opacity(timerManager.isPaused ? 1 : 0)
                    .disabled(!timerManager.isPaused)
                }
                .frame(height: 100)
                .animation(.easeInOut, value: timerManager.isPaused)

                Spacer()
            }
            .padding(.horizontal, 40)

            if showAlert {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .transition(.opacity)

                CustomAlertView(
                    showAlert: $showAlert,
                    title: "End Timer",
                    message: "Are you sure you want to end the timer?",
                    onConfirm: {
                        timerManager.stopTimer()
                    }
                )
                .transition(.scale)
            }
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

