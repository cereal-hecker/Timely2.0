//
//  UserManager.swift
//  Timely
//
//  Created by user2 on 27/02/24.
//

import Foundation
import Firebase
import FirebaseFirestore

struct DBUser: Codable {
    let userId: String
    let email: String
    let userName: String
    let dateCreaed: Date?
    
    init(auth: AuthDataModel){
        self.userId = auth.uid
        self.email = auth.email
        self.userName = auth.userName
        self.dateCreaed = Date()
    }
    var initials: String {
        let nameComponents = userName.components(separatedBy: " ")
        let firstInitial = nameComponents.first?.first ?? Character("")
        let lastInitial = nameComponents.last?.first ?? Character("")
        return String(firstInitial) + String(lastInitial)
    }
}



final class UserManager: ObservableObject {
    
    private let userCollection = Firestore.firestore().collection("users")
    
    private func userDocument(userId: String) -> DocumentReference {
        userCollection.document(userId)
    }
    
    private let encoder: Firestore.Encoder = {
        let encoder = Firestore.Encoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()
    private let decoder: Firestore.Decoder = {
        let decoder = Firestore.Decoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    func createNewUser(user: DBUser) async throws {
        try userDocument(userId: user.userId).setData(from: user, merge: false, encoder: encoder)
    }
    func getUser(userId: String) async throws -> DBUser {
        try await userDocument(userId: userId).getDocument(as: DBUser.self, decoder: decoder)
    }
    
    // MARK: createNewUser and getUser in detail long method
//    func createNewUser(auth: AuthDataModel) async throws {
//        var userData: [String:Any] = [
//            "userId": auth.uid,
//            "email": auth.email,
//            "userName": auth.userName ?? "NO NAME",
//            "dateCreated": Timestamp()
//        ]
//        try await userDocument(userId: auth.uid).setData(userData,merge: false)
//    }
    
    
//    func getUser(userId: String) async throws -> DBUser {
//        let snapshot = try await userDocument(userId: userId).getDocument()
//        
//        guard let data = snapshot.data() else {
//            throw URLError(.badServerResponse)
//        }
//        guard let userId = data["userId"] as? String, let email = data["email"] as? String, let userName = data["userName"] as? String else {
//            throw URLError(.badServerResponse)
//        }
//        
//        
//        let dateCreated = data["dateCreated"] as? Date
//        
//        return DBUser(userId: userId, email: email, userName: userName, dateCreaed: dateCreated)
//        
//    }
//    
//    
//    func updateName(user: DBUser) async throws {
//        try userDocument(userId: user.userId).setData(from: user, merge: true, encoder: encoder)
//    }
}
