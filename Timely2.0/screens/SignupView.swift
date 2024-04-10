//
//  SignUp.swift
//  Timely
//
//  Created by user2 on 06/02/24.
//

import SwiftUI
import Firebase
import FirebaseFirestore

class SignupViewManager: ObservableObject {
    @Published var username: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmpassword: String = ""
    @Published var errorMessage: String = ""
    init() {}
    
    @MainActor
    func register() async throws {
        guard validate() else {
            return
        }
        errorMessage = try await AuthenticationManager.shared.createUser(withEmail: email, password: password, username: username)
    }
    
    func validate() -> Bool {
        guard !username.trimmingCharacters(in: .whitespaces).isEmpty,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty,
              !confirmpassword.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        guard email.contains("@") && email.contains(".") else {
            return false
        }
        guard password.count >= 6 else {
            return false
        }
        guard confirmpassword == password else {
            return false
        }
        return true
    }
}

struct Signup: View {
    
    @StateObject var viewModel = SignupViewManager()
    @State var isVerificationSheetPresented: Bool = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack{
                    Image("pet1")
                        .resizable()
                        .frame(width: 265, height: 269)
                        .offset(y: 40)
                        .zIndex(1)
                    if !isVerificationSheetPresented {
                        ZStack {
                            Image(.grad1)
                                .offset(y: -350)
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(maxWidth: .infinity)
                                .background(Color.grey2)
                                .cornerRadius(50)
                            VStack{
                                TimelyText()
                                    .padding(.bottom)
                                    .padding(.top, -14)
                                VStack {
                                    InputView(text: $viewModel.email, title: "email", placeholder: "Email", offsetval: -108)
                                        .autocapitalization(.none)
                                    
                                    InputView(text: $viewModel.username, title: "username", placeholder: "UserName", offsetval: -90)
                                    
                                    InputView(text: $viewModel.password, title: "password", placeholder: "Password", offsetval: -90, isSecureField: true)
                                        .autocapitalization(.none)
                                    
                                    ZStack(alignment:.trailing) {
                                        InputView(text: $viewModel.confirmpassword, title: "confirm password", placeholder: "Confirm Password", offsetval: -56, isSecureField: true)
                                            .autocapitalization(.none)
                                            .padding(.bottom,4)
                                        if !viewModel.password.isEmpty && !viewModel.confirmpassword.isEmpty {
                                            if viewModel.password == viewModel.confirmpassword {
                                                Image(systemName: "checkmark.circle.fill")
                                                    .imageScale(.large)
                                                    .fontWeight(.bold)
                                                    .foregroundStyle(Color.green)
                                                    .offset(x:-8,y:-12)
                                            }else{
                                                Image(systemName: "checkmark.circle.fill")
                                                    .imageScale(.large)
                                                    .fontWeight(.bold)
                                                    .foregroundStyle(Color.red)
                                                    .offset(x:-8,y:-12)
                                            }
                                        }
                                    }
                                    // MARK: Error handling for signup
                                    if viewModel.errorMessage != "" {
                                        Text("\(viewModel.errorMessage)")
                                            .font(.caption)
                                            .foregroundStyle(Color.red)
                                    }
                                    
                                    // MARK: Sign Up Button
                                    Button(action: {
                                        Task {
                                            Task{
                                                try await viewModel.register()
                                            }
                                        }
                                    }) {
                                        Text("SIGN UP")
                                            .foregroundColor(.black)
                                            .font(.system(size: 20).weight(.semibold))
                                            .padding(.vertical, 14)
                                            .padding(.horizontal, 114)
                                            .background(.primarypink)
                                            .cornerRadius(20)
                                    }
                                    .disabled(!viewModel.validate())
                                    .opacity(viewModel.validate() ? 1.0 : 0.6)
                                    
                                    HStack{
                                        Text("Already have an account?")
                                            .font(.caption)
                                            .foregroundStyle(Color.white)
                                        Button{
                                            dismiss()
                                        }label: {
                                            Text("LOG IN")
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
                            .padding(.vertical, 15)
                            .padding(.horizontal, 20)
                            .background(Color.grey2)
                            .cornerRadius(40)
                            .padding(20)
                        }
                    } else {
                        //  VerificationCard(isOn: isVerificationSheetPresented)
                    }
                }
            }
            .background(Color.black)
            .ignoresSafeArea(.all)
        }
    }
}

// MARK: AuthenticationFormProtocol
//extension Signup: AuthenticationFormProtocol {
//    var formIsValid: Bool {
//        return !email.isEmpty
//        && email.contains("@")
//        && !password.isEmpty
//        && password.count>5
//        && confirmpassword == password
//        && !username.isEmpty
//    }
//}

#Preview {
    Signup()
}

