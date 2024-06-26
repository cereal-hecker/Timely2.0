//
//  LoginView.swift
//  timelyNew
//
//  Created by user2 on 25/01/24.
//
import SwiftUI
import FirebaseAuth

final class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String = ""
    
    init() {}
    
    func login() async throws {
        guard validate() else {
            return
        }
        
        do {
            errorMessage = try await AuthenticationManager.shared.signInUser(withEmail: email, password: password)
        } catch {
            errorMessage = "Login failed: Enter valid Credential"
            print("Error signing in:", error.localizedDescription)
        }
    }

    
    private func validate() -> Bool {
        errorMessage = ""
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Please fill in all fields"
            return false
        }
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Please enter a valid email"
            return false
        }
        return true
    }
}

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    
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
                        
                        InputView(text: $viewModel.email, title: "email", placeholder: "Email",offsetval: -108)
                            .autocapitalization(.none)
                        
                        InputView(text: $viewModel.password, title: "password", placeholder: "Password",offsetval: -90, isSecureField: true)
                            .autocapitalization(.none)
                        
                        Button{
                            // AuthenticationManager.shared.resetPassword(email:)
                        }label: {
                            Text("Forgot password ?")
                                .font(.caption)
                                .foregroundColor(Color.white)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .padding(.top,1)
                                .padding(.bottom,2)
                                .offset(y:-6)
                        }
                        // MARK: Error handle
                        if viewModel.errorMessage != "" {
                            Text("\(viewModel.errorMessage)")
                                .foregroundStyle(Color.red)
                        }
                        
                        // MARK: Login button
                        Button{
                            Task{
                                try await viewModel.login()
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
                        
                        Text("or continue with")
                            .font(.caption)
                            .colorInvert()
                            .padding(4)
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
                        .padding(.top,2)
                        .padding(.bottom)
                        
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
extension LoginView {
    var formIsValid: Bool {
        return !viewModel.email.isEmpty
        && viewModel.email.contains("@")
        && !viewModel.password.isEmpty
        && viewModel.password.count>5
    }
}


#Preview {
    LoginView()
}



