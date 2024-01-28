//
//  ContentView.swift
//  Timely2.0
//
//  Created by Riya Batla on 27/01/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Schedule()
//                .badge(2)
                .tabItem {
                    Label("Schedule", image: "calendar")
                }
            Landing()
                .tabItem {
                    Label("Home", image: "home")
                }
            Schedule()
                .tabItem {
                    Label("Leaderboard", image: "leaderboard")
                }
            Profile()
//                .badge("!")
                .tabItem {
                    Label("Profile", image: "profile")
                }
        }
        .environment(\.colorScheme, .dark)
        
    }
}

#Preview {
    ContentView()
}
