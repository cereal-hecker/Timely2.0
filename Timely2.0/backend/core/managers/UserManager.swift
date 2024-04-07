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
import FirebaseStorage

final class UserManager {
    @Published var currentUser: User?
    @Published var profileImage: UIImage?
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
    
    // MARK: user fetching function
    @MainActor
    func fetchCurrentUser() async throws {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let db = Firestore.firestore()
        let snapshot = try await db.collection("customer").document(uid).getDocument()
        let user = try snapshot.data(as: User.self)
        self.currentUser = user
        
        print("DEBUG: User is \(user)")
    }
    
    // MARK: task completed updating
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
    
    // MARK: User hp and level updated
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
    
    // MARK: Deleting a task
    func deleteTask(task: UserTask){
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let db = Firestore.firestore()
        db.collection("customer").document(uid).collection("tasks").document(task.id).delete { error in
            if let error = error {
                print("Error deleting task: \(error)")
            } else {
                print("Task deleted successfully")
            }
        }
    }

    // MARK: remove the user from local
    func reset() {
        self.currentUser = nil
    }
    
    // MARK: Delete the task older than one year
    func deleteOldData() {
        let oneYearAgo = Calendar.current.date(byAdding: .year, value: -1, to: Date())!
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        let db = Firestore.firestore()
        let query = db.collection("customer").document(uid).collection("tasks").whereField("dateTime", isLessThan: oneYearAgo)
        
        query.getDocuments { (snapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
                return
            }
            for document in snapshot!.documents {
                document.reference.delete()
            }
        }
    }
    
    // MARK: Uploading and Updating Profile Pick
    func uploadProfileImage(image: UIImage) {
            guard let uid = Auth.auth().currentUser?.uid else {
                print("User not authenticated.")
                return
            }
        print("starteduploading")
            let storageRef = Storage.storage().reference()
            let profileImageRef = storageRef.child("profileImage/\(uid).jpg")
            
            // Convert image to JPEG data
            guard let imageData = image.jpegData(compressionQuality: 0.5) else {
                print("Failed to convert image to data.")
                return
            }
            
            // Upload image data to Firebase Storage
            profileImageRef.putData(imageData, metadata: nil) { metadata, error in
                if let error = error {
                    print("Error uploading profile image: \(error.localizedDescription)")
                } else {
                    print("Profile image uploaded successfully.")
                }
            }
    }
    
    // MARK: Fetch Profile Image
     func fetchProfileImage() {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("User not authenticated.")
            return
        }
        print("fetch was called")
        
        let storageRef = Storage.storage().reference()
        let profileImageRef = storageRef.child("profileImage/\(uid).jpg")
        
        profileImageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print("Error fetching profile image: \(error.localizedDescription)")
            } else {
                
                if let data = data, let image = UIImage(data: data) {
                    print(image)
                    self.profileImage = image
                }
            }
        }
    }
}

