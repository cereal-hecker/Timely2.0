//
//  TagBar.swift
//  Timely2.0
//
//  Created by Riya Batla on 28/01/24.
//

import SwiftUI

struct TagBar: View {
    
    var tagList: [String] = ["All", "Important", "College", "Friends"]
    
    var body: some View {
        HStack(spacing: 15){
            ForEach(tagList, id: \.self) { tag in
                Button(tag) {
                    print("Button tapped!")
                }
                .buttonStyle(
                    RoundedButtonStyle(
                        backgroundColor: .grey1,
                        pressedBackgroundColor: .white,
                        borderColor: .white,
                        foregroundColor: .grey7,
                        pressedForegroundColor: .black,
                        cornerRadius: 8))
            }
        }
//        .background(Color.black)
    }
}

#Preview {
    TagBar()
}
