//
//  RootView.swift
//  Timely2.0
//
//  Created by user2 on 29/02/24.
//

import SwiftUI
import FirebaseAuth
import Firebase

struct RootView: View {
    @State var selection = 2
    
    var body: some View {
        ZStack{
            NavigationStack{
                TabView(selection: $selection){
                    Schedule()
                        .badge(2)
                        .tabItem {
                            Label("Schedule", image: "calendar")
                        }.tag(1)
                    LandingView(userId: Auth.auth().currentUser?.uid ?? "")
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
            }
        }
    }
}

#Preview {
    RootView()
}
