//
//  PetItem.swift
//  Timely2.0
//
//  Created by Riya Batla on 30/01/24.
//

import SwiftUI

struct PetItem: View {
    let imageName: String
    
    var body: some View {
        ZStack(alignment: .bottom){
            Rectangle()
                .foregroundColor(.tagpurple)
                .frame(width: 170, height: 80)
                .cornerRadius(20)
            Image(imageName)
        }
    }
}

#Preview {
    PetItem(imageName: "cat")
}

