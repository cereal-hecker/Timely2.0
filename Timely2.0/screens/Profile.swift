//
//  Profile.swift
//  Timely2.0
//
//  Created by Riya Batla on 29/01/24.
//

import SwiftUI

import SwiftUI

struct Profile: View {
    @State private var isPetSheetPresented = false
    @State private var isHistorySheetPresented = false
    
    var body: some View {
        ZStack {
            Color(.black).edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading) { // Set alignment to leading
                Text("Profile")
                    .font(.system(size: 28, weight: .heavy, design: .default))
                    .foregroundColor(.white)
                    .padding()

                Text("Avatar") // New text for the section name
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()

                VStack {
                    HStack{
                        Image("pet")
                            .resizable()
                            .renderingMode(.original)
                            .frame(width: 35, height: 35) // Set the image size
                            .padding(.leading)
                            .offset(CGSize(width: 0, height: 0))
                        
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
                //                    .navigationBarTitle("Mission")
                                    .foregroundColor(.white)
                                    .environment(\.colorScheme, .dark)
                            }
                        }
                        .padding(.leading)
                        .foregroundColor(.white)
                        .offset(CGSize(width: 0, height: 0))
                        
                    }
                    
                    HStack{
                        Image("history")
                            .resizable()
                            .renderingMode(.original)
                            .frame(width: 30, height: 30) // Set the image size
                            .padding(.leading)
                            .offset(CGSize(width: 12, height: 0))
                        
                        Button(action: {isHistorySheetPresented.toggle()}, label: {
                            Text("History")
                        })
                        .sheet(isPresented: $isHistorySheetPresented) {
                            NavigationView {
                                HistoryView()
                                    .background(Color.grey1)
                                    .foregroundColor(.white)
                                    .navigationBarItems(
                                        trailing: Button(action: {
                                            isHistorySheetPresented.toggle()
                                        }) {
                                            Image(systemName: "xmark.circle.fill")
                                        }
                                    )
                //                    .navigationBarTitle("Mission")
                                    .foregroundColor(.white)
                                    .environment(\.colorScheme, .dark)
                            }
                        }
                        .padding(.leading)
                        .foregroundColor(.white)
                        .offset(CGSize(width: 18, height: 0))
                    }
                }
                
                Text("Account") // New text for the section name
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()

                VStack {
                    HStack{
                        Image("edit")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .padding(.leading)
                            .offset(CGSize(width: -15, height: 0))
                        
                        Button(action: {}, label: {
                            Text("Edit Profile")
                        })
                        .padding(.leading)
                        .foregroundColor(.white)
                        .offset(CGSize(width: -12, height: 0))
                    }
                    
                    HStack{
                        Image("logout")
                            .resizable()
                            .renderingMode(.original)
                            .frame(width: 30, height: 30) // Set the image size
                            .padding(.leading)
                            .offset(CGSize(width: -23, height: 0))
                        
                        Button(action: {}, label: {
                            Text("Log Out")
                        })
                        .padding(.leading)
                        .foregroundColor(.white)
                        .offset(CGSize(width: -20, height: 0))
                    }
                    
                    HStack{
                        Image("terms")
                            .resizable()
                            .renderingMode(.original)
                            .frame(width: 35, height: 35) // Set the image size
                            .padding(.leading)
                            .offset(CGSize(width: 18, height: 0))
                        
                        Button(action: {}, label: {
                            Text("Terms and Policies")
                        })
                        .padding(.leading)
                        .foregroundColor(.white)
                        .offset(CGSize(width: 18, height: 0))
                    }

                }

                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
    }
}
    
    

#Preview {
    Profile()
}

