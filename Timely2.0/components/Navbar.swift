//
//  Navbar.swift
//  Timely2.0
//
//  Created by Riya Batla on 28/01/24.
//

import SwiftUI

struct Navbar: View {
    var body: some View {
        TabView {
            StartedCard()
//                .badge(2)
                .tabItem {
                    Label("Schedule", image: "calendar")
                }
            StartedCard()
                .tabItem {
                    Label("Home", image: "home")
                }
            StartedCard()
//                .badge("!")
                .tabItem {
                    Label("Leaderboard", image: "leaderboard")
                }
            StartedCard()
//                .badge("!")
                .tabItem {
                    Label("Profile", image: "profile")
                }
        }
    }
}

#Preview {
    Navbar()
}
