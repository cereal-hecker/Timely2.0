//
//  LandingView.swift
//  Timely2.0
//
//  Created by Riya Batla on 29/01/24.
//

import SwiftUI
import FirebaseFirestoreSwift
import Firebase
import FirebaseAuth
import CoreLocation

@MainActor
class LandingViewModel: ObservableObject {
    @Published var userId: String = ""
    @Published var contentChanged: Bool = false
    @Published var levelDocId: String = ""
    
    init(userId: String) {
        self.userId = userId
    }
    
    
    
    
}
struct LandingView: View {
    private var userId: String
        @FirestoreQuery var items: [UserTask]
    @FirestoreQuery var leaderboard: [Leaderboard]
        

        @State private var isLongPressed = false
        @Binding var showSignInView: Bool
        @StateObject private var authManager = AuthenticationManager()
        
        @StateObject var viewModel: LandingViewModel
        
        init(userId: String, showSignInView: Binding<Bool>) {
            self.userId = userId
            self._items = FirestoreQuery(collectionPath: "user/\(userId)/tasks")
            self._leaderboard = FirestoreQuery(collectionPath: "user/\(userId)/level")
            self._showSignInView = showSignInView
            self._viewModel = StateObject(wrappedValue: LandingViewModel(userId: userId))
        }
    var body: some View {
        NavigationView {
            
            ScrollView {
                VStack {

                    Text("Level 0")
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
                                
                                self.isLongPressed.toggle()
                            }
                            .sheet(isPresented: $isLongPressed) {
                                ChoosePetSheet()
                                    .background(.black)
                            }
                    }
                    .frame(height: 520)
                    VStack {
                        Spacer()
                        HealthCard(currentHealth: Double(0), maxHealth: 100, level:0)
                            .padding(.bottom)
                        if items.filter({ $0.dateTime > Date().timeIntervalSince1970 && !$0.isCompleted }).isEmpty {
                            
                            HStack(spacing:30) {
                                Text("No Upcoming Tasks ...")
                            }
                            .padding(5)
                            .padding()
                            .background(.grey2)
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            
                            
                        } else {
                            ForEach(items.filter { $0.dateTime > Date().timeIntervalSince1970 && !$0.isCompleted }.sorted(by: { $0.dateTime < $1.dateTime })) { task in
                                UpcomingEventCard( item: task, contentChanged: $viewModel.contentChanged)
                                    .cornerRadius(10)
                                    .padding(.bottom, 5)
                            }
                            
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
        .onChange(of: viewModel.contentChanged) { _ in
                                
                            }
    }

}

#Preview{
    LandingView(userId: "j76lsrc1gCZ22iQfz1SwxDdwMoG2", showSignInView: .constant(true))
}
