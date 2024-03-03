//
//  UpcomingEventCard.swift
//  Timely2.0
//
//  Created by Riya Batla on 28/01/24.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class UpcomingEventCardModel: ObservableObject {
    init() {}
    func toggleIsComplete(item: UserTask) {
        var itemCopy = item
        itemCopy.setDone(!item.isCompleted)
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        let db = Firestore.firestore()
        db.collection("user").document(uid).collection("tasks").document(itemCopy.id).setData(itemCopy.asDictionary())
    }
}

struct UpcomingEventCard: View {
    @StateObject var viewModel = UpcomingEventCardModel()
    let item : UserTask

    var body: some View {
        HStack() {
            VStack(alignment: .leading) {
                Text(item.dateTime.formatted())
                    .font(.caption)
                HStack(alignment: .lastTextBaseline) {
                    Text(item.dateTime.formatted())
                        .font(.title2)
                        .bold()
                }
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text(item.venue)
                    .font(.title2)
                    .bold()
                Text(item.venue)
                    .font(.caption)
                    .italic()
            }
            Button {
                viewModel.toggleIsComplete(item: item)
            } label: {
                Image( systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
            }
        }
        .padding(5)
        .padding()
        .background(.grey2)
        .cornerRadius(10)
        .foregroundColor(.white)
    }
}

#Preview {
    UpcomingEventCard( item: .init(
        id: "123",
        venue: "IOS Bootcamp",
        dateTime: Date().timeIntervalSince1970,
        category: "important",
        isCompleted: true
        ))
}
