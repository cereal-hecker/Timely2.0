//
//  UserManager.swift
//  Timely2.0
//
//  Created by user2 on 14/03/24.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

final class UserManager {
    @Published var currentUser: User?
    
    static let shared = UserManager()
    
    init() {
        Task {
            do {
                try await fetchCurrentUser()
            }catch{
                print("DEBUG: error in fetching user data")
            }
        }
    }
    
    @MainActor
    func fetchCurrentUser() async throws {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let db = Firestore.firestore()
        let snapshot = try await db.collection("customer").document(uid).getDocument()
        let user = try snapshot.data(as: User.self)
        self.currentUser = user
        
        print("DEBUG: User is \(user)")
    }
    func toggleIsComplete(item: UserTask) {
        var itemCopy = item
        itemCopy.setDone(!item.isCompleted)
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        guard let itemCopyEncoded = try? Firestore.Encoder().encode(itemCopy) else {return}
        let db = Firestore.firestore()
        db.collection("customer").document(uid).collection("tasks").document(itemCopy.id).setData(itemCopyEncoded)
    }
    
    @MainActor
    func updateUserLevel(Hp: Int){
        currentUser?.changeHp(Hp)
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        guard let userCopyEncoded = try? Firestore.Encoder().encode(currentUser) else {return}
        let db = Firestore.firestore()
        db.collection("customer").document(uid).setData(userCopyEncoded)
    }
    
    func reset() {
        self.currentUser = nil
    }
}

