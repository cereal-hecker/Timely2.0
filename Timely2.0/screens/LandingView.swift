//
//  LandingView.swift
//  Timely2.0
//
//  Created by Riya Batla on 29/01/24.
//

import SwiftUI

struct LandingView: View {
    var body: some View {
        NavigationStack{
            VStack{
                Text("Level 16")
                    .font(.title2)
                    .foregroundColor(.white)
                    .bold()
                Spacer()
                ZStack{
                    Image("landglow")
                        .offset(x: 10, y: -40)
                    SplineCard()
                }
                VStack{
                    Spacer()
                    HealthCard(currentHealth: 541, maxHealth: 1000, level: 13)
                        .padding(.bottom, 5)
                    UpcomingEventCard()
                        .cornerRadius(10)
                        .padding(.bottom, 5)
                    AddMission()
                }
                .offset(y: -20)
            }
            .padding()
    //        .frame(minHeight: .infinity)
            .background(.black)
        }
    }
}

#Preview {
    LandingView()
}
