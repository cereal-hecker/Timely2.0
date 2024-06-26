//
//  File.swift
//  Timely2.0
//
//  Created by user2 on 14/03/24.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class AuthenticationManager {
    @Published var userSession: FirebaseAuth.User?
    static let shared = AuthenticationManager()
    
    init(){
        self.userSession = Auth.auth().currentUser
    }
    @MainActor
    func createUser(withEmail email: String, password: String, username: String) async throws -> String {
        do{
            
            let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = authResult.user
            
            try await insertUserRecord(id: authResult.user.uid, username: username, email: email)
        }catch{
            print("failed to create User with error: \(error.localizedDescription)")
            return "Sign Up Failed: Enter valid credintials"
        }
        return ""
    }
    
    
    @MainActor
    private func insertUserRecord(id: String, username: String, email: String) async throws {
        let newUser = User(id: id,
                           username: username,
                           email: email,
                           dateJoined: Date().timeIntervalSince1970,
                           currentHp: 300,
                           level: 0)
        
        guard let userData = try? Firestore.Encoder().encode(newUser) else {return}
        let db = Firestore.firestore()
        try await db.collection("customer").document(id).setData(userData)
        UserManager.shared.currentUser = newUser
    }
    
    @MainActor
    func signInUser(withEmail email: String, password: String) async throws -> String {
        do{
            let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = authResult.user
            try await UserManager.shared.fetchCurrentUser()
            print(authResult.user.uid)
        } catch {
            print("failed to login with error \(error.localizedDescription)")
            return "Login Failed: Invalid login details"
        }
        return ""
    }
    
//    func updateEmail(newEmail: String) async throws {
//        do {
//            Auth.auth().currentUser?.updateEmail(to: newEmail) { error in
//                if let error = error {
//                    print(error)
//                }
//            }
//            let user = Auth.auth().currentUser
//            var credential: AuthCredential
//
//            // Prompt the user to re-provide their sign-in credentials
//
//            user?.reauthenticate(with: credential) {_,_ in 
//            }
//            
//        }
//    }
    
    func updateEmail(email: String) async throws {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        
        try await user.updatePassword(to: email)
        print("updateemail")
    }
    
    func updatePassword(password: String) async throws {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
    
        try await user.updatePassword(to: password)
        print("updatedpass")
    }
    
    func resetPassword(email: String) async throws {
        do {
            try await Auth.auth().sendPasswordReset(withEmail: email)
            print("Password updated")
        } catch let error as NSError {
            print("error")
            throw error
        }
    }
    
    
    func signOut() {
        try? Auth.auth().signOut()
        self.userSession = nil
        UserManager.shared.reset()
    }
    
}
