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
import FirebaseStorage


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
    
    @State private var profileImage: UIImage?
    
    @State private var isPetSheetPresented = false
    @State private var isHistorySheetPresented = false
    @State private var isEditProfilePresented = false
    
    
    private var currentUser: User? {
        return viewModel.currentUser
    }
    var body: some View {
        NavigationStack {
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
                                if profileImage != nil {
                                    Image(uiImage: profileImage ?? UIImage(systemName: "person.circle")!)
                                        .resizable()
                                        .frame(width: 72, height: 72)
                                        .cornerRadius(72)
                                } else {
                                    Text(currentUser?.initials ?? "")
                                        .font(.title)
                                        .fontWeight(.semibold)
                                        .frame(width: 72, height: 72)
                                        .background(Color.gray)
                                        .clipShape(Circle())
                                        .foregroundColor(.white)
                                }
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
                        
                        Section("History"){
                            
                            //                        HStack{
                            //                            Image("pet")
                            //                                .resizable()
                            //                                .renderingMode(.original)
                            //                                .frame(width: 35, height: 35) // Set the image size
                            //                                .padding(.leading)
                            //
                            //                            Button(action: {isPetSheetPresented.toggle()}, label: {
                            //                                Text("Pet")
                            //                            })
                            //                            .sheet(isPresented: $isPetSheetPresented) {
                            //
                            //                                NavigationView {
                            //                                    ChoosePetSheet()
                            //                                        .background(Color.grey1)
                            //                                        .foregroundColor(.white)
                            //                                        .navigationBarItems(
                            //                                            trailing: Button(action: {
                            //                                                isPetSheetPresented.toggle()
                            //                                            }) {
                            //                                                Image(systemName: "xmark.circle.fill")
                            //                                            }
                            //                                        )
                            //                                        .environment(\.colorScheme, .dark)
                            //                                }
                            //                            }
                            //                            .padding(.leading)
                            //                            .foregroundColor(.white)
                            //                        }
                            
                            HStack{
                                Image("history")
                                    .resizable()
                                    .renderingMode(.original)
                                    .frame(width: 35, height: 35) // Set the image size
                                    .padding(.leading)
                                
                                Button(action: {isEditProfilePresented.toggle()}, label: {
                                    Text("History")
                                })
                                .sheet(isPresented: $isEditProfilePresented) {
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
                            
                            
                            
                            NavigationLink{
                                EditProfileView()
                            } label: {
                                HStack{
                                    Image("edit")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .padding(.leading)
                                    
                                    Text("Edit Profile")
                                        .padding(.leading)
                                        .foregroundColor(.white)
                                }
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
                            .buttonStyle(PlainButtonStyle())
                            .onAppear() {
                                
                            }
                            
                            Button{
                                
                            } label: {
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
                        }
                        .foregroundStyle(Color.white)
                        .font(.headline)
                        .padding(.bottom, 10)
                        .listRowBackground(Color.grey1)
                    }
                    Image(uiImage: profileImage ?? UIImage(systemName: "person.circle")!)
                        .resizable()
                        .frame(width: 100, height: 100)
                }
                .scrollContentBackground(.hidden)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
            .onAppear {
                fetchProfileImage()
            }
        }
    }
    
    // MARK: Fetch Profile Image
    private func fetchProfileImage() {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("User not authenticated.")
            return
        }
        print("fetch was called")
        
        let storageRef = Storage.storage().reference()
        let profileImageRef = storageRef.child("profileImage/\(uid).jpg")
        
        // Fetch image data from Firebase Storage
        profileImageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print("Error fetching profile image: \(error.localizedDescription)")
            } else {
                
                if let data = data, let image = UIImage(data: data) {
                    print(image)
                    self.profileImage = image
                }
            }
        }
    }
    
}

#Preview {
    ProfileView()
}
