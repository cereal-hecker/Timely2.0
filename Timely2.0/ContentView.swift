//
//  ContentView.swift
//  Timely2.0
//
//  Created by Riya Batla on 27/01/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State var selection = 2

    var body: some View {
        Group {
            if viewModel.userSession != nil {
                if let user = viewModel.currentUser {
                    TabView(selection: $selection){
                        Schedule()
                            .badge(2)
                            .tabItem {
                                Label("Schedule", image: "calendar")
                            }.tag(1)
                        LandingView()
                            .tabItem {
                                Label("Home", image: "home")
                            }.tag(2)
                        LeaderboardView()
                            .tabItem {
                                Label("Leaderboard", image: "leaderboard")
                            }.tag(3)
                        ProfileView()
                            .tabItem {
                                Label("Profile", image: "profile")
                            }.tag(4)
                    }
                    .environment(\.colorScheme, .dark)
                }else{
                    ZStack {
                        Color.black.opacity(0.8) // Semi-transparent black background
                                    .ignoresSafeArea()

                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle())
                                    .foregroundColor(.white)
                            }
                }
            }else{
                GetStartedView()
            }
        }
        //LocationVerification()
        
    }
}

#Preview {
    ContentView()
}
