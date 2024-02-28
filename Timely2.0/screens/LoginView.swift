//
//  LoginView.swift
//  timelyNew
//
//  Created by user2 on 25/01/24.
//

import SwiftUI

struct LoginView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            VStack{
                Spacer()
                Image("pet1")
                    .resizable()
                    .frame(width: 265, height: 269)
                    .offset(y: 40)
                    .zIndex(1)
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
                        
                        InputView(text: $email, title: "email", placeholder: "Email",offsetval: -108)
                            .autocapitalization(.none)
                        
                        InputView(text: $password, title: "password", placeholder: "Password",offsetval: -90, isSecureField: true)
                            .autocapitalization(.none)
                        
                        
                        Text("Forgot password?")
                            .font(.caption)
                            .foregroundColor(Color.white)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.horizontal)
                            .padding(.bottom)
                        
                        // MARK: Login button
                        
                        Button{
                            Task{
                                try await viewModel.signIn(withEmail: email , password: password)
                            }
                        } label: {
                            Text("LOGIN")
                                .navigationBarBackButtonHidden(true)
                                .foregroundColor(.black)
                                .font(.system(size: 20).weight(.semibold))
                                .padding(.vertical, 10)
                                .padding(.horizontal, 122.0)
                                .background(Color(.primarypink))
                                .cornerRadius(9)
                        }
                        .disabled(!formIsValid)
                        .opacity(formIsValid ? 1.0 : 0.6)
                        
                        HStack{
                            Text("Don't have an account?")
                                .foregroundStyle(Color.white)
                                .font(.caption)
                            NavigationLink{
                                Signup()
                                    .navigationBarBackButtonHidden()
                            }label: {
                                Text("Register Here!")
                                    .navigationBarBackButtonHidden(true)
                                    .font(.footnote)
                                    .foregroundStyle(Color.blue)
                                    .bold()
                            }
                            
                            
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
            .background(.black)
        .ignoresSafeArea()
        }
        
    }
}

// MARK: AuthenticationFormProtocol
extension LoginView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count>5
    }
}



#Preview {
    LoginView()
}



