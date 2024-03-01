//
//  AuthenticationManager.swift
//  Timely2.0
//
//  Created by user2 on 29/02/24.
//

import Foundation
import FirebaseAuth


protocol AuthenticationFormProtocol{
    var formIsValid: Bool {get}
}


struct AuthDataModel {
    let uid: String
    let email: String!
    let userName: String
    
    
}

final class AuthenticationManager: ObservableObject {
    
    
    
    func createUser(withEmail email: String, password: String, username: String) async throws -> AuthDataModel {
        do{
            let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
            let user = authResult.user
            let result = AuthDataModel(uid: user.uid, email: user.email, userName: username)
            return result
        }catch{
            print("failed \(error.localizedDescription)")
            throw error
        }
    }
    
    func getProvider() throws {
        guard let providerData = Auth.auth().currentUser?.providerData else {
            throw URLError(.badServerResponse)
        }
        for provider in providerData {
            print(provider.providerID)
        }
    }
    
    func getAuthenticatedUser() throws -> AuthDataModel {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        return AuthDataModel(uid: user.uid, email: user.email, userName: user.displayName ?? "NO Name")
    }

    
    func signOut() {
        do{
            try Auth.auth().signOut()
        }catch{
            print("fail to signout\(error.localizedDescription)")
        }
    }
}

// MARK: SIGN IN WITH EMAIL
extension AuthenticationManager {
    
    @discardableResult
    func signInUser(withEmail email: String, password: String) async throws -> AuthDataModel {
        do{
            let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
            let user = authResult.user
            let result = AuthDataModel(uid: user.uid, email: user.email, userName: user.displayName ?? "No Name")
            return result
        } catch {
            print("failed to login with error \(error.localizedDescription)")
            throw error
        }
    }
    
    func fetchUser() throws -> AuthDataModel {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        return AuthDataModel(uid: user.uid, email: user.email , userName: user.displayName ?? "No Name")
    }
    
    func resetPassword(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
}

// MARK: SIGN IN ANONYMOUS
//extension AuthenticationManager {
//    @discardableResult
//    func signInAnonymous() async throws -> AuthDataModel {
//        let authResult = try await Auth.auth().signInAnonymously()
//        let user = authResult.user
//        let result = AuthDataModel(uid: user.uid, email: user.email, userName: user.displayName, isAnonymous: user.isAnonymous)
//        return result
//    }
//    
//    func linkEmail(email: String, password: String) async throws -> AuthDataModel {
//        let credential = EmailAuthProvider.credential(withEmail: email, link: password)
//        
//        guard let user = Auth.auth().currentUser else {
//            throw URLError(.badURL)
//        }
//        let authResult = try await user.link(with: credential)
//        let result = AuthDataModel(uid: authResult.user.uid, email: authResult.user.email, userName: authResult.user.displayName, isAnonymous: authResult.user.isAnonymous)
//        return result
//    }
//}

