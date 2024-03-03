//
//  LandingView.swift
//  Timely2.0
//
//  Created by Riya Batla on 29/01/24.
//

import SwiftUI
import FirebaseFirestoreSwift
class LandingViewModel: ObservableObject {
    
    
}

struct LandingView: View {
    var userId: String
    @FirestoreQuery var items: [UserTask]

    init(userId: String, showSignInView: Binding<Bool>) {
        self.userId = userId
        self._items = FirestoreQuery(collectionPath: "user/\(userId)/tasks") // Initialize items here
        self._showSignInView = showSignInView
    }
    @StateObject var viewModel = LandingViewModel()
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
                                
                                self.isLongPressed.toggle()
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
                        ForEach(items.filter { !$0.isCompleted }.sorted(by: { $0.dateTime < $1.dateTime })) { task in
                            UpcomingEventCard(item: task)
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
    LandingView(userId: "V6faODeEAyeC1oSHuA4YJJ6Jd513", showSignInView: .constant(true))}
