//
//  ChoosePetSheet.swift
//  Timely2.0
//
//  Created by Riya Batla on 30/01/24.
//

import SwiftUI

struct ChoosePetSheet: View {
    @State private var petName = "Cosmo"
    @State private var Likes = "Likes"
    
    var body: some View {
        ZStack {
            Color(.black).edgesIgnoringSafeArea(.all)
            VStack() {
                Rectangle()
                    .foregroundColor(Color.white.opacity(0.6))
                    .frame(width: 36, height: 5)
                
                VStack {
                    Text("Pet")
                        .font(.system(size: 28, weight: .heavy, design: .default))
                        .foregroundColor(.white)
                        .padding()
                        .offset(CGSize(width: -160.0, height: 0))
                
                    
                    HStack{
                        Image("pet1")
                            .resizable()
                            .frame(width: 170,height: 170)
                            .padding()
                            .offset(CGSize(width: 0, height: -75))
                        
                        VStack{
                            TextField("Pet Name", text: $petName)
                                .padding(.horizontal)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .foregroundColor(.black)
                                .opacity(0.3)
                                .frame(width: 100)
                                .offset(CGSize(width: 0, height: -100))
                            
                            TextField("Likes", text: $Likes)
                                .padding(.horizontal)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .foregroundColor(.black)
                                .opacity(0.3)
                                .frame(width: 100)
                                .offset(CGSize(width: 0, height: -90))

                        }
                        
                        VStack{
                            Image("edit")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.white)
                                .opacity(0.5)
                                .padding()
                                .offset(CGSize(width: 0, height: -62))
                            
                            Image("like")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .padding()
                                .offset(CGSize(width: 0, height: -70))
                            
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            })
                            Text("Select")
                                .font(.system(size: 12, weight: .light, design: .default))
                                .foregroundColor(.white)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 30).fill(Color.white).opacity(0.2))
                                .offset(CGSize(width: -10.0, height: -70.0))
                                .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)

                        }
                    }
                }
                Spacer()
                
                Image("pets")
                    .resizable().ignoresSafeArea(.all)
                    .frame(width: 360, height: 420)
                    .padding(EdgeInsets())
                    .offset(CGSize(width: 0, height: -25))
            }
        }
    }
}

#Preview {
    ChoosePetSheet()
}
