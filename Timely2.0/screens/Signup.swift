//
//  LoginView.swift
//  timelyNew
//
//  Created by user2 on 25/01/24.
//

import SwiftUI


struct Signup: View {
    var isVerification: Bool = false
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack{
                    Image("pet1")
                        .resizable()
                        .frame(width: 265, height: 269)
                        .offset(y: 40)
                        .zIndex(1)
                    Spacer()
                    if !isVerification {
                        SignUpTitleCard()
                    } else {
                       //VerificationCard(isOn: isVerification)
                    }
                }
            }
            .background(Color.black)
            .ignoresSafeArea(.all)
        }
    }
}

#Preview {
    Signup()
}


struct SignUpTitleCard: View {
    var body: some View {
        ZStack {
            Image(.grad1)
                .offset(y: -350)
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: .infinity)
                .background(Color.grey2)
                .cornerRadius(50)
            VStack{
                TimelyText()
                    .padding(.bottom)
                    .padding(.top, -14)
                SignUpCard()
            }
            .padding(.vertical, 15)
            .padding(.horizontal, 20)
            .background(Color.grey2)
            .cornerRadius(40)
            .padding(20)
        }
    }
}


struct SignUpCard: View {
    
    @State private var username: String = ""
    @State private var password: String = ""
    
    @State private var email: String = ""
    @State private var confirmpassword: String = ""
    
    var body: some View {
        VStack {
            TextField("Email",text: $email)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.white, lineWidth: 1)
                )
                .padding(.bottom, 10)
                .overlay(
                    Text("email")
                        .padding(.horizontal, 5)
                        .font(.headline)
                        .background(Color.grey2)
                        .foregroundColor(.white)
                        .offset(x: -108, y: -32)
                )
            
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
                .padding(.bottom, 10)
                .overlay(
                    Text("password")
                        .padding(.horizontal, 5)
                        .font(.headline)
                        .background(Color.grey2)
                        .foregroundColor(.white)
                        .offset(x: -90, y: -28)
                )
            
            TextField("ConfirmPassword",text: $confirmpassword)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.white, lineWidth: 1)
                )
                .overlay(
                    Text("confirm password")
                        .padding(.horizontal, 5)
                        .font(.headline)
                        .background(Color.grey2)
                        .foregroundColor(.white)
                        .offset(x: -56, y: -28)
                )
                .padding(.bottom)
            
            NavigationLink("SIGN UP") {
//                VerificationView()
//                .navigationBarBackButtonHidden(true)
            }
            .foregroundColor(.black)
            .font(.system(size: 20).weight(.semibold))
            .padding(.vertical, 14)
            .padding(.horizontal, 114)
            .background(.primarypink)
            .cornerRadius(20)
            
            
            HStack{
                Text("Already have an account?")
                    .font(.caption)
                    .foregroundStyle(Color.white)
                NavigationLink("LOG IN") {
                    LoginView()
                        .navigationBarBackButtonHidden(true)
                }
                .navigationBarBackButtonHidden(true)
                .font(.footnote)
                .bold()
            }
            
            
            Text("or continue with").font(.caption)
                .foregroundStyle(Color.white)
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
        }
    }
}



//struct VerificationCard: View {
//    @State private var otp1: String = ""
//    var isOn: Bool
//
//    var body: some View{
//        NavigationStack {
//            VStack{
//                Rectangle()
//                    .foregroundColor(.clear)
//                    .frame(width: .infinity)
//                    .cornerRadius(50)
//                TimelyText()
//                    .padding(-1)
//                ZStack {
//                    Rectangle()
//                        .foregroundColor(.clear)
//                        .frame(width: .infinity)
//                        .background(.grey2)
//                        .cornerRadius(50)
//                    VStack(alignment: .leading){
//                        Text("Verification")
//                            .font(Font.custom("Inter", size: 32))
//                            .foregroundStyle(Color.white)
//                        Text("We have sent the verification code to T****ar@gmail.com")
//                            .foregroundStyle(Color.white)
//                            .font(.caption)
//                        HStack {
//                            Text("You can")
//                                .font(.caption)
//
//                            Text("Change here!")
//                                .font(.footnote)
//                                .bold()
//                        }
//                        .padding(0)
//                        .offset(x:-90)
//                        Text("VerificationCode")
//                            .font(.headline)
//                            .foregroundStyle(Color.white)
//                            .padding()
//                            .padding()
//                        HStack{
//                            TextField("1", text: $otp1)
//                                .frame(width: 28.0, height: 34.0)
//                                .background(Color.white)
//                        }
//                        Text("Re-Send Code")
//
//                        Button(/*@START_MENU_TOKEN@*/"Button"/*@END_MENU_TOKEN@*/) {
//                            /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
//                        }
//                        .frame(width: .infinity, height: 50)
//                        .foregroundColor(.black)
//                        .background(Color.primarypink)
//                    }
//                    .padding()
//
//                }
//                .background(.grey2)
//                .cornerRadius(40)
//                .padding(20)
//            }
//            .padding(-1)
//        }
//    }
//}
//
