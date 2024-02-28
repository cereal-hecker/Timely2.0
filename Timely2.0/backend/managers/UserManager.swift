////
////  UserManager.swift
////  Timely
////
////  Created by user2 on 27/02/24.
////
//
//import Foundation
//import Firebase
//import FirebaseFirestore
//
//final class UserManager {
//    static let shared = UserManager()
//    private init(){ }
//    
//    func getUser(userId: String) async throws -> String {
//        let snapshot = try await Firestore.firestore().collection("users").document(userId).getDocument()
//        
//        guard let data = snapshot.data() else {
//            throw URLError(.badServerResponse)
//        }
//        
//        let userId = data["id"] as? String
//        let isAnonymous = data["isAnonymous"] as? Bool
//        let email = data["email"] as? String
//
//    }
//    
//}
