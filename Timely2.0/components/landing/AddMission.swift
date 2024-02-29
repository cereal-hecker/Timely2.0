//
//  AddMission.swift
//  Timely2.0
//
//  Created by Riya Batla on 29/01/24.
//

import SwiftUI

struct AddMission: View {
    @State private var isSheetPresented = false
    @Binding var showSignInView: Bool
    @StateObject private var authManager = AuthenticationManager()
    var body: some View {
        ZStack(alignment: .trailing) {
            HStack {
                
                Button{
                    isSheetPresented.toggle()
                }label:{
                    Image(systemName: "plus")
                        .padding()
                        .background(.primarypink)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                }
                

            }
            .sheet(isPresented: $isSheetPresented ) {
                
                    NavigationView {
                        MissionSheet()
                            .background(.grey1)
                            .navigationBarItems(
                                trailing:  Button(action:{isSheetPresented.toggle()}){
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.grey7)
                                }
                            ) .navigationBarTitle("Add Mission")
                            .foregroundColor(.white)
                            .environment(\.colorScheme, .dark)
                }
                .onAppear {
                    let authUser = try? authManager.fetchUser()
                    self.showSignInView = authUser == nil
                    print("useris ther in add mission \(String(describing: authUser))")
                }
                .fullScreenCover(isPresented: $showSignInView) {
                    NavigationStack {
                        LoginView(showSignInView: $showSignInView)
                    }
                    
                }
                
            }
        }
            }
}

#Preview {
    AddMission(showSignInView: .constant(true))
}

