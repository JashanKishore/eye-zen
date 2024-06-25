//
//  CustomAlertView.swift
//  eye-zen
//
//  Created by Jashan kishore on 25/6/2024.
//

import SwiftUI

struct CustomAlertView: View {
    @Binding var showAlert: Bool
    var title: String
    var message: String
    var onConfirm: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text(title)
                .font(.headline)
                .padding(.top)
            Text(message)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            HStack(spacing: 20) {
                Button(action: {
                    withAnimation {
                        showAlert = false
                    }
                }) {
                    Text("Cancel")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray)
                        .cornerRadius(10)
                }

                Button(action: {
                    withAnimation {
                        showAlert = false
                        onConfirm()
                    }
                }) {
                    Text("End")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .frame(width: 300)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 10)
        .padding(.horizontal, 20)
        .transition(.scale)
    }
}

