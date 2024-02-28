//
//  TextField.swift
//  Timely
//
//  Created by user2 on 06/02/24.
//

import SwiftUI

struct InputView: View {
    @Binding var text: String
    let title: String
    let placeholder: String
    let offsetval: Int
    var isSecureField = false
    
    var body: some View {
        VStack{
            if isSecureField {
                SecureField(placeholder, text: $text)
                .padding()
                .background{
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.white, lineWidth: 1)
                }
                .padding(.bottom,10)
                .overlay(
                    Text(title)
                        .padding(.horizontal, 5)
                        .font(.headline)
                        .background(Color.grey2)
                        .foregroundColor(.white)
                        .offset(x: CGFloat(offsetval) ,y:-32)
                )
                
            }else{
                TextField(placeholder, text: $text)
                    .padding()
                    .background{
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.white, lineWidth: 1)
                    }
                    .padding(.bottom,10)
                    .overlay(
                        Text(title)
                            .padding(.horizontal, 5)
                            .font(.headline)
                            .background(Color.grey2)
                            .foregroundColor(.white)
                            .offset(x: CGFloat(offsetval) ,y:-32)
                    )
            }
            
        }
    }
}

#Preview {
    InputView(text: .constant(""), title: "email", placeholder: "abc@example.com", offsetval: -108)
}
