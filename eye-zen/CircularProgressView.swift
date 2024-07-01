//
//  CircularProgressView.swift
//  eye-zen
//
//  Created by Jashan kishore on 1/7/2024.
//

import SwiftUI

struct CircularProgressView: View {
    var progress: CGFloat
    var lineWidth: CGFloat = 10.0
    var circleColor: Color = .blue
    var backgroundColor: Color = .gray.opacity(0.3)
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(backgroundColor, lineWidth: lineWidth)
            
            Circle()
                .trim(from: 0.0, to: progress)
                .stroke(circleColor, lineWidth: lineWidth)
                .rotationEffect(.degrees(-90))
                .animation(.linear, value: progress)  // Updated animation modifier
        }
    }
}

struct CircularProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressView(progress: 0.7)
            .frame(width: 100, height: 100)
    }
}

