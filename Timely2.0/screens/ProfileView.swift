//
//  ProfileView.swift
//  Timely
//
//  Created by user2 on 06/02/24.
//

import SwiftUI
import Combine
import FirebaseFirestore
import FirebaseAuth
import _CoreLocationUI_SwiftUI


final class ProfileViewModel: ObservableObject {
    @Published var currentUser: User?
    private var cancellables = Set<AnyCancellable>()
    init() {
        setupUser()
    }
    
    private func setupUser(){
        UserManager.shared.$currentUser.sink { [weak self] user in
            self?.currentUser = user
            print("DEBUG: User in viewModel from Profile is \(String(describing: user))")
        }.store(in: &cancellables)
    }
}

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    
    @State private var isPetSheetPresented = false
    @State private var isHistorySheetPresented = false
    
    private var currentUser: User? {
        return viewModel.currentUser
    }
    var body: some View {
        ZStack {
            Color(.black).edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading) {
                Text("Profile")
                    .font(.system(size: 28, weight: .heavy, design: .default))
                    .foregroundColor(.white)
                    .padding(.horizontal)
                
                List{
                    Section{
                        HStack(alignment: .center) {
                            Text(currentUser?.initials ?? "")
                                .font(.title)
                                .fontWeight(.semibold)
                                .frame(width: 72, height: 72)
                                .background(.grey2)
                                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                .foregroundStyle(.white)
                            VStack(alignment:.leading){
                                Text(currentUser?.email ?? "")
                                    .font(.footnote)
                                    .foregroundColor(.white)
                                Text(currentUser?.username ?? "")
                                    .font(.footnote)
                                    .foregroundColor(.white)
                                
                            }
                            .padding(.leading, 30)
                        }
                        .padding(2)
                    }
                    .listRowBackground(Color.grey1)
                    
                    Section("Avatar"){
                        
                        HStack{
                            Image("pet")
                                .resizable()
                                .renderingMode(.original)
                                .frame(width: 35, height: 35) // Set the image size
                                .padding(.leading)
                            
                            Button(action: {isPetSheetPresented.toggle()}, label: {
                                Text("Pet")
                            })
                            .sheet(isPresented: $isPetSheetPresented) {
                                
                                NavigationView {
                                    ChoosePetSheet()
                                        .background(Color.grey1)
                                        .foregroundColor(.white)
                                        .navigationBarItems(
                                            trailing: Button(action: {
                                                isPetSheetPresented.toggle()
                                            }) {
                                                Image(systemName: "xmark.circle.fill")
                                            }
                                        )
                                        .environment(\.colorScheme, .dark)
                                }
                            }
                            .padding(.leading)
                            .foregroundColor(.white)
                        }
                        HStack{
                            Image("history")
                                .resizable()
                                .renderingMode(.original)
                                .frame(width: 35, height: 35) // Set the image size
                                .padding(.leading)
                            
                            Button(action: {isHistorySheetPresented.toggle()}, label: {
                                Text("History")
                            })
                            .sheet(isPresented: $isHistorySheetPresented) {
                                NavigationView {
                                    HistoryView(userId: currentUser?.id ?? "nil")
                                        .background(Color.grey1)
                                        .foregroundColor(.white)
                                        .navigationBarItems(
                                            trailing: Button(action: {
                                                isHistorySheetPresented.toggle()
                                            }) {
                                                Image(systemName: "xmark.circle.fill")
                                            }
                                        )
                                        .environment(\.colorScheme, .dark)
                                }
                            }
                            .padding(.leading)
                            .foregroundColor(.white)
                        }
                    }
                    .foregroundStyle(Color.white)
                    .font(.headline)
                    .padding(.bottom, 10)
                    .listRowBackground(Color.grey1)
                    
                    Section("Account"){
                        
                        HStack{
                            Image("edit")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .padding(.leading)
                            
                            Button(action: {}, label: {
                                Text("Edit Profile")
                            })
                            .padding(.leading)
                            .foregroundColor(.white)
                        }
                        
                        Button{
                            Task{
                                AuthenticationManager.shared.signOut()
                            }
                        } label: {
                            HStack{
                                Image("logout")
                                    .resizable()
                                    .renderingMode(.original)
                                    .frame(width: 30, height: 30) // Set the image size
                                    .padding(.leading)
                                Text("Log Out")
                                    .padding(.leading)
                                    .foregroundColor(.white)
                            }
                        }
                        .onAppear() {
                            
                        }
                        
                        HStack{
                            Image("terms")
                                .resizable()
                                .renderingMode(.original)
                                .frame(width: 35, height: 35) // Set the image size
                                .padding(.leading)
                            
                            Button(action: {}, label: {
                                Text("Terms and Policies")
                            })
                            .padding(.leading)
                            .foregroundColor(.white)
                        }
                    }
                    .foregroundStyle(Color.white)
                    .font(.headline)
                    .padding(.bottom, 10)
                    .listRowBackground(Color.grey1)
                }
            }
            .scrollContentBackground(.hidden)
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
        .onAppear {
        }
    }
}

#Preview {
    ProfileView()
}

