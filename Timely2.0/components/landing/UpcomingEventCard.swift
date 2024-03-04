//
//  UpcomingEventCard.swift
//  Timely2.0
//
//  Created by Riya Batla on 28/01/24.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import MapKit

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
                let remainingTime = calculateRemainingTime()
                if remainingTime.hours > 0 {
                    Text("\(remainingTime.hours) hours left")
                        .font(.caption)
                } else if remainingTime.minutes > 0 {
                    Text("\(remainingTime.minutes) minutes left")
                        .font(.caption)
                } else {
                    Text("\(remainingTime.seconds) seconds left")
                        .font(.caption)
                }
                
                HStack(alignment: .lastTextBaseline) {
                    Text(formatDate(item.dateTime,format:"hh:mm a"))
                        .font(.title2)
                        .bold()
                }
                Text("Early by: \(item.earlyTime)")
                    .font(.caption)
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
    private func calculateRemainingTime() -> (hours: Int, minutes: Int, seconds: Int) {
           let currentDate = Date().timeIntervalSince1970
           let remainingTime = max(0, item.dateTime - currentDate)
           
           let hours = Int(remainingTime / 3600)
           let minutes = Int((remainingTime.truncatingRemainder(dividingBy: 3600)) / 60)
           let seconds = Int(remainingTime.truncatingRemainder(dividingBy: 60))
           
           return (hours, minutes, seconds)
       }
    
    private func formatDate(_ timestamp: TimeInterval, format: String = "MMM d, yyyy h:mm a") -> String {
            let date = Date(timeIntervalSince1970: timestamp)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = format
            return dateFormatter.string(from: date)
        }
    
}


#Preview {
    UpcomingEventCard(item: .init(
        id: "123",
        venue: "IOS Bootcamp",
        dateTime: Date().timeIntervalSince1970,
        location: GeoPoint(latitude: 12.82318919, longitude: 80.04440627),
        repeatTask: "once",
        earlyTime: "min10",
        tags: ["important"],
        isCompleted: false
    ))

}
