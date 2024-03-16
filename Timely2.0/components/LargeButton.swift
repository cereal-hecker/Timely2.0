//
//  LargeButton.swift
//  Timely2.0
//
//  Created by Riya Batla on 28/01/24.
//

import SwiftUI

struct LargeButtonStyle: ButtonStyle {
    
    let backgroundColor: Color
    let foregroundColor: Color
    let textColor: Color
    let isDisabled: Bool
    
    func makeBody(configuration: Self.Configuration) -> some View {
        let isPressed = configuration.isPressed
        let currentBackgroundColor = isDisabled ? backgroundColor.opacity(0.3) : (isPressed ? foregroundColor : backgroundColor)
        let currentForegroundColor = isDisabled || isPressed ? foregroundColor.opacity(0.3) : foregroundColor
        
        return configuration.label
            .padding()
            .foregroundColor(currentForegroundColor)
            .background(currentBackgroundColor)
            .cornerRadius(6)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(currentForegroundColor, lineWidth: 1)
            )
            .padding([.top, .bottom], 10)
            .font(Font.system(size: 19, weight: .semibold))
    }
}

struct LargeButton: View {
    
    private static let buttonHorizontalMargins: CGFloat = 20
    
    var backgroundColor: Color
    var foregroundColor: Color
    var textColor: Color
    
    private let title: String
    private let action: () -> Void
    
    // It would be nice to make this into a binding.
    private let disabled: Bool
    
    init(title: String,
         disabled: Bool = false,
         backgroundColor: Color = Color.green,
         foregroundColor: Color = Color.white,
         textColor: Color = Color.black, // Added textColor property
         action: @escaping () -> Void) {
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.textColor = textColor
        self.title = title
        self.action = action
        self.disabled = disabled
    }
    
    var body: some View {
        HStack {
            Spacer(minLength: LargeButton.buttonHorizontalMargins)
            Button(action:self.action) {
                Text(self.title)
                    .foregroundColor(self.textColor) // Set text color here
            }
            .buttonStyle(LargeButtonStyle(backgroundColor: backgroundColor,
                                          foregroundColor: foregroundColor,
                                          textColor: textColor,
                                          isDisabled: disabled))
            .disabled(self.disabled)
            Spacer(minLength: LargeButton.buttonHorizontalMargins)
        }
        .frame(maxWidth:.infinity)
    }
}

#Preview {
    LargeButton(title: "Invite a Friend",
                backgroundColor: Color.white,
                foregroundColor: Color.green,
                textColor: Color.black) {
        print("Hello World")
    }
}
