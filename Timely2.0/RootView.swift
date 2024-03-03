//
//  RootView.swift
//  Timely2.0
//
//  Created by user2 on 29/02/24.
//

import SwiftUI
import FirebaseAuth

class RootViewModel: ObservableObject{
    @Published var currentUserId: String = ""
    private var handler: AuthStateDidChangeListenerHandle?
    
    init(){
        self.handler = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            DispatchQueue.main.async {
                self?.currentUserId = user?.uid ?? ""
            }
        }
    }
    public var isSignedIn: Bool {
        return Auth.auth().currentUser != nil
    }
}
struct RootView: View {
    
    @State private var showSignInView: Bool = false
    @StateObject var authManager = AuthenticationManager()
@StateObject var viewModel = RootViewModel()
    @State var selection = 1
    var body: some View {
        ZStack{
            NavigationStack{
                if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty {
                    
                        TabView(selection: $selection){
                            Schedule()
                                .badge(2)
                                .tabItem {
                                    Label("Schedule", image: "calendar")
                                }.tag(1)
                            LandingView(userId: viewModel.currentUserId,showSignInView: $showSignInView)
                                .tabItem {
                                    Label("Home", image: "home")
                                }.tag(2)
                            LeaderboardView()
                                .tabItem {
                                    Label("Leaderboard", image: "leaderboard")
                                }.tag(3)
                            ProfileView(showSignInView: $showSignInView)
                                .tabItem {
                                    Label("Profile", image: "profile")
                                }.tag(4)
                        
                    }.environment(\.colorScheme, .dark)
                    
                    
                }else{
                    LoginView(showSignInView: $showSignInView)
                }
            }
            
        }
    }
}

#Preview {
    RootView()
}
