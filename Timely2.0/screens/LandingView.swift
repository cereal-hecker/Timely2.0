//
//  LandingView.swift
//  Timely2.0
//
//  Created by Riya Batla on 29/01/24.
//

import SwiftUI

struct LandingView: View {
    @State private var isLongPressed = false
    @Binding var showSignInView: Bool
    @StateObject private var authManager = AuthenticationManager()
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text("Level 16")
                        .font(.title2)
                        .foregroundColor(.white)
                        .bold()
                    Spacer()
                    ZStack {
                        Image("landglow")
                            .offset(x: 10, y: -40)
                        SplineCard()
                            .offset(y: 20)
                            .onLongPressGesture(minimumDuration: 1.0) {
                                // Handle long press action
                                self.isLongPressed.toggle()
                                // Additional actions for long press if needed
                            }
                            .sheet(isPresented: $isLongPressed) {
                                // The view or content you want to show on long press
                                ChoosePetSheet()
                                    .background(.black)
                            }
                    }
                    .frame(height: 520)
                    VStack {
                        Spacer()
                        HealthCard(currentHealth: 541, maxHealth: 1000, level: 13)
                            .padding(.bottom, 5)
                        
                        ForEach(0...5, id: \.self) { events in
                            UpcomingEventCard()
                                .cornerRadius(10)
                                .padding(.bottom, 5)
                        }
                        
                    }
                    .offset(y: -20)
                }
                .padding()
                
            }
            .navigationBarHidden(true) // Hide navigation bar if you don't need it
            .background(Color.black)
            .overlay(
                AddMission(showSignInView: $showSignInView)
                    .position(CGPoint(x: 350.0, y: 490.0))
                    
            )
        }
    }
}

#Preview{
    LandingView(showSignInView: .constant(false))
}
