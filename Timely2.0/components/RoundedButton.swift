//
//  RoundedButton.swift
//  Timely2.0
//
//  Created by Riya Batla on 28/01/24.
//

import SwiftUI

struct RoundedButtonStyle: ButtonStyle {
    var backgroundColor: Color
    var pressedBackgroundColor: Color
    var borderColor: Color
    var foregroundColor: Color
    var pressedForegroundColor: Color
    var cornerRadius: CGFloat

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.caption)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .foregroundColor(configuration.isPressed ? pressedForegroundColor : foregroundColor)
            .background(configuration.isPressed ? pressedBackgroundColor : backgroundColor)
            .cornerRadius(cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(borderColor, lineWidth: 2)
            )
    }
}

struct RoundedButton: View {
    var body: some View {
        Button("Click me") {
            // Add your button action here
            print("Button tapped!")
        }
        .buttonStyle(RoundedButtonStyle(backgroundColor: .blue,
                                        pressedBackgroundColor: .green,
                                        borderColor: .green,
                                        foregroundColor: .white,
                                        pressedForegroundColor: .white,
                                        cornerRadius: 10))
    }
}
#Preview {
    RoundedButton()
}
