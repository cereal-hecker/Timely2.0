//
//  LoginView.swift
//  timelyNew
//
//  Created by user2 on 25/01/24.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        NavigationStack{
            VStack{
                Spacer()
                Image("pet1")
                    .resizable()
                    .frame(width: 265, height: 269)
                    .offset(y: 40)
                .zIndex(1)
                LoginCard()
            }
            .background(.black)
            .ignoresSafeArea()
        }
    }
}

#Preview {
    LoginView()
}





struct LoginCard: View {
    
    @State private var username: String = ""
    @State private var password: String = ""
    
    var body: some View {
        ZStack(alignment: .top) {
//            RadialColorGradiant()
//                .offset(y:-400)
            Image("grad1")
                .offset(y: -250)
            Rectangle()
                .foregroundColor(.clear)
                .background(Color.grey2)
                .cornerRadius(50)
            VStack{
                TimelyText()
                    .padding(.bottom)
                    .padding(.top,4)
                
                TextField("Username", text: $username)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.white, lineWidth: 1)
                    )
                    .padding(.bottom, 10)
                    .overlay(
                        Text("username")
                            .padding(.horizontal, 5)
                            .font(.headline)
                            .background(Color.grey2)
                            .foregroundColor(.white)
                            .offset(x: -90, y: -34)
                    )
                
                
                TextField("Password",text: $password)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.white, lineWidth: 1)
                    )
                    .overlay(
                        Text("password")
                            .padding(.horizontal, 5)
                            .font(.headline)
                            .background(Color.grey2)
                            .foregroundColor(.white)
                            .offset(x: -90, y: -28)
                    )

                
                Text("Forgot password?")
                    .font(.caption)
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.horizontal)
                    .padding(.bottom)
                
                NavigationLink("LOGIN") {
                    Landing()
                    .navigationBarBackButtonHidden(true)
                }
                .navigationBarBackButtonHidden(true)
                .foregroundColor(.black)
                .font(.system(size: 20).weight(.semibold))
                .padding(.vertical, 10)
                .padding(.horizontal, 122.0)
                .background(Color(.primarypink))
                .cornerRadius(9)
                HStack{
                    Text("Don't have an account?")
                        .foregroundStyle(Color.white)
                        .font(.caption)
                    NavigationLink("Register here!"){
                            Signup()
                            .navigationBarBackButtonHidden(true)
                    }
                    .navigationBarBackButtonHidden(true)
                    .font(.footnote)
                    .bold()

                }
                
                Text("or continue with").font(.caption)
                    .colorInvert()
                    .padding()
                HStack{
                    Image("apple")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding(.trailing)
                    Image("google")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding(.leading)
                }
                
                Spacer()
            }
            .padding(.vertical, 15)
            .padding(.horizontal, 20)
            .background(Color.grey2)
            .cornerRadius(40)
            .padding(23)
            
            
        }
    }
}
