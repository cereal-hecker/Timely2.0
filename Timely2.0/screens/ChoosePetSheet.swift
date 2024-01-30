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
        ZStack(alignment: .bottom) {
            Color(.black).edgesIgnoringSafeArea(.all)
            
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 393, height: 480)
                .background(Color(red: 0.17, green: 0.17, blue: 0.18))
                .cornerRadius(20)
            
            
            VStack() {
                
                VStack {
                    Text("Pet")
                        .font(.system(size: 28, weight: .heavy, design: .default))
                        .foregroundColor(.white)
                        .padding()
                        .offset(CGSize(width: -150.0, height: 0))
                    
                    HStack{
                        Image("pet1")
                            .resizable()
                            .frame(width: 170,height: 170)
                            .padding()
                        
                        VStack{
                            HStack{
                                TextField("Pet Name", text: $petName)
                                    .padding(.horizontal)
                                
                                Image("edit")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .padding()
                            }
                            .foregroundColor(.white)
                            .background(Color.grey2)
                            
                            HStack{
                                TextField("Likes", text: $Likes)
                                    .padding(.horizontal)
                                
                                Image("like")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .padding()
                            }
                            .foregroundColor(.white)
                            .background(Color.grey2)
                            
                            HStack(){
                                Spacer()
                                Button(action: {}, label: {
                                })
                                Text("Select")
                                    .font(.system(size: 12, weight: .light, design: .default))
                                    .foregroundColor(.white)
                                    .padding(.horizontal)
                                    .padding(.vertical, 10)
                                    .background(RoundedRectangle(cornerRadius: 30).fill(Color.white).opacity(0.2))
                                    .padding(.vertical)
                            }
                            
                        }
                    }
                    VStack(alignment: .leading){
                        Text("Choose Your Pet")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.white)
                            .padding()
                        
                        HStack {
                            Image("pet2")
                                .resizable()
                                .frame(width: 150, height: 158)
                                .padding()
                            
                            Image("pet3")
                                .resizable()
                                .frame(width: 150, height: 158)
                                .padding()
                        }
                        
                        HStack {
                            Image("pet4")
                                .resizable()
                                .frame(width: 150, height: 158)
                                .padding()
                            
                            Image("pet5")
                                .resizable()
                                .frame(width: 150, height: 158)
                                .padding()
                        }

                    }
                }
                Spacer()
            }
        }
    }
}


#Preview {
    ChoosePetSheet()
}
