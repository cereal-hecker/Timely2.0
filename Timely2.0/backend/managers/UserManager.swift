//
//  UserManager.swift
//  Timely
//
//  Created by user2 on 27/02/24.
//

import Foundation
import Firebase
import FirebaseFirestore


//var initials: String {
//        guard let userName = userName else { return "" }
//        
//        let nameComponents = userName.components(separatedBy: " ")
//        let firstInitial = nameComponents.first?.first ?? Character("")
//        let lastInitial = nameComponents.last?.first ?? Character("")
//        
//        return String(firstInitial) + String(lastInitial)
//    }

final class UserManager: ObservableObject {
    
    func createNewUser(auth: AuthDataModel) async throws {
        var userData: [String:Any] = [
            "userId": auth.uid,
            "email": auth.email,
            "userName": auth.userName ?? "NO NAME",
            "dateCreated": Timestamp()
        ]
        try await Firestore.firestore().collection("users").document(auth.uid).setData(userData,merge: false)
        
        
        //
        //    func getUser(userId: String) async throws -> String {
        //        let snapshot = try await Firestore.firestore().collection("users").document(userId).getDocument()
        //
        //        guard let data = snapshot.data() else {
        //            throw URLError(.badServerResponse)
        //        }
        //
        //        let userId = data["userId"] as? String
        //        let email = data["email"] as? String
        //        let userName = data[""]
        //
        //    }
        
    }
}
