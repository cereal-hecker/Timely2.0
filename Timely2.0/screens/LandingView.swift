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
import Combine
import CoreLocation


@MainActor
class LandingViewModel: ObservableObject {
    @Published var contentChanged: Bool = false
    @Published var levelDocId: String = ""
    @Published var currentUser: User?
    private var cancellables = Set<AnyCancellable>()
    init() {
        setupUser()
    }
    
    func setupUser(){
        UserManager.shared.$currentUser.sink { [weak self] user in
            self?.currentUser = user
            print("DEBUG: User in viewModel from Profile is \(String(describing: user))")
        }.store(in: &cancellables)
    }
}

struct LandingView: View {
    @State var userId: String
    @StateObject var viewModel = LandingViewModel()
    @FirestoreQuery var items: [UserTask]
    @State private var isLongPressed: Bool = false
    
    
    init(userId: String) {
        self.userId = userId
        self._items = FirestoreQuery(collectionPath: "customer/\(userId)/tasks")
    }
    
    private var currentUser: User? {
        return viewModel.currentUser
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text("Level ").font(.title2).bold().foregroundStyle(.white) + Text(String(currentUser?.level ?? 0))
                        .font(.title2)
                        .foregroundColor(.white)
                        .bold()
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
                    }.frame(height: 480)
                    
                    VStack {
                        Spacer()
                        HealthCard(currentHealth: Double(currentUser?.currentHp ?? 0), maxHealth: 100, level:0)
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
            .navigationBarHidden(true)
            .background(Color.black)
            .overlay(
                AddMission()
                    .position(CGPoint(x: 350.0, y: 490.0))
            )
        }
        .onChange(of: viewModel.contentChanged) {
            
        }
    }
}

#Preview{
    LandingView(userId:"Vb6MhTUkUjfsh42tNZPAR0zWL8F3")
}
