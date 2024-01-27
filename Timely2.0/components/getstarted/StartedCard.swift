//
//  StartedCard.swift
//  Timely2.0
//
//  Created by Riya Batla on 27/01/24.
//

import SwiftUI

struct StartedCard: View {
    var body: some View {
        ZStack(alignment: .bottom){
            UnevenRoundedRectangle(cornerRadii: .init(
                topLeading: 50,
                topTrailing: 50),
                style: .continuous)
                .frame(height: 393)
                .foregroundColor(.secondarygrey)
            VStack(){
                Text("timely")
                    .font(.system(size: 80).weight(.black))
                    .padding(.bottom, 7)
                Text("Tardiness is curable")
                    .font(.title2)
                    .bold()
                    .padding(.bottom, 8)
                Text("Schedule the day and actually follow it")
                    .font(.caption)
                    .opacity(0.6)
                Text("throughout by taking care of your pet!")
                    .font(.caption)
                    .opacity(0.6)
                ZStack(alignment: .bottom){
                    Rectangle()
                        .fill(.tertiarypurple)
                        .frame(width: 100, height: 10)
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Text("Get started")
                    })
                }
                .padding(.bottom)
                Image("paw-clip")
            }
            .foregroundColor(.white)
        }
    }
}

#Preview {
    StartedCard()
}
