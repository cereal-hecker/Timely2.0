//
//  coping.swift
//  Timely2.0
//
//  Created by user2 on 07/04/24.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct ConView: View {
    @State private var sourceUserID: String = ""
    @State private var destinationUserID: String = ""

    // Function to copy tasks from the source user to the destination user
    func copyTasks() {
        // Fetch tasks from the Firestore database for the source user
        Firestore.firestore().collection("customer/\(sourceUserID)/tasks").getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else {
                print("Error fetching tasks for source user: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            // Iterate through the documents and copy each task to the destination user
            for document in documents {
                let data = document.data()
                // Save the task to the Firestore collection of the destination user
                Firestore.firestore().collection("customer/\(destinationUserID)/tasks").addDocument(data: data) { error in
                    if let error = error {
                        print("Error copying task: \(error.localizedDescription)")
                    } else {
                        print("Task copied successfully.")
                    }
                }
            }
        }
    }

    var body: some View {
        VStack {
            TextField("Source User ID", text: $sourceUserID)
                .padding()
            TextField("Destination User ID", text: $destinationUserID)
                .padding()
            Button("Copy Tasks") {
                copyTasks() // Call the function to copy tasks
            }
            .padding()
        }
        .padding()
    }
}
