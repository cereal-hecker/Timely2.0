//
//  Landing.swift
//  Timely2.0
//
//  Created by Riya Batla on 29/01/24.
//

import SwiftUI

struct Landing: View {
    var body: some View {
        VStack{
            UpcomingEventCard()
            ZStack{
                Image("landglow")
                    .offset(x: 10, y: -40)
                SplineCard()
            }
            Text("Level 16")
                .font(.title2)
                .foregroundColor(.white)
                .bold()
            HealthCard(currentHealth: 541, maxHealth: 1000, level: 13)
                .padding(.bottom)
            AddMission()
            Spacer()
        }
        .padding()
//        .frame(minHeight: .infinity)
        .background(.black)
    }
}

#Preview {
    Landing()
}
