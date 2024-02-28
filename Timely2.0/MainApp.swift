//
//  MainApp.swift
//  Timely2.0
//
//  Created by Riya Batla on 30/01/24.
//

import SwiftUI

struct MainApp: View {
    
    @State var selection = 2
    
    var body: some View {
        TabView(selection: $selection){
            Schedule()
//                .badge(2)
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
//                .badge("!")
                .tabItem {
                    Label("Profile", image: "profile")
                }.tag(4)
        }
        .environment(\.colorScheme, .dark)
    }
}

#Preview {
    MainApp()
}
