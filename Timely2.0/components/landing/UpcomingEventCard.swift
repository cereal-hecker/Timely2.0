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
    @Published var remainingTime = (hours: 0, minutes: 0, seconds: 0)

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
    @ObservedObject private var viewModel: UpcomingEventCardModel
        let item: UserTask
        @Binding var contentChanged: Bool
        @State private var timer: Timer?

        init(item: UserTask, contentChanged: Binding<Bool>) {
            self.viewModel = UpcomingEventCardModel()
            self.item = item
            self._contentChanged = contentChanged
            viewModel.remainingTime = calculateRemainingTime(item: item)
        }
    var body: some View {
        HStack() {
            VStack(alignment: .leading) {
                VStack {
                    if viewModel.remainingTime.hours > 0 {
                        Text("\(viewModel.remainingTime.hours) hours left")
                            .font(.caption)
                    } else if viewModel.remainingTime.minutes > 0 {
                        Text("\(viewModel.remainingTime.minutes) minutes left")
                            .font(.caption)
                    } else {
                        Text("\(viewModel.remainingTime.seconds) seconds left")
                            .font(.caption)
                    }
                }
                HStack(alignment: .lastTextBaseline) {
                    Text(formatDate(item.dateTime, format: "hh:mm a"))
                        .font(.title2)
                        .bold()
                }
                Text("Early by: \(formatEarlyTime(item.earlyTime))")
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
                Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
            }
        }
        .padding(5)
        .padding()
        .background(Color.grey2)
        .cornerRadius(10)
        .foregroundColor(.white)
        .onAppear{
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                updateRemainingTime(item: item)
            }
        }
        .onDisappear {
                    timer?.invalidate()
                    timer = nil
                }

        
        
    }
    private func formatEarlyTime(_ earlyTime: String) -> String {
        let minutes = earlyTime.components(separatedBy: CharacterSet.decimalDigits.inverted)
            .compactMap { Int($0) }
            .first ?? 0
        
        return "early by \(minutes) min"
    }
    

    private func formatDate(_ timestamp: TimeInterval, format: String = "MMM d, yyyy h:mm a") -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    
    private func updateRemainingTime(item: UserTask) {
        viewModel.remainingTime = calculateRemainingTime(item: item)
        
        if viewModel.remainingTime.hours == 0 && viewModel.remainingTime.minutes == 0 && viewModel.remainingTime.seconds == 0 {
            
            
            // MARK: location Verification
            self.locationChecker(item: item)
            
            // MARK: content toggler
            self.contentChanged.toggle()
            print("Toglercallesd")
            
        }
        print("hour \(viewModel.remainingTime.hours) min \(viewModel.remainingTime.minutes) sec \(viewModel.remainingTime.seconds)")
    }

    private func calculateRemainingTime(item: UserTask) -> (hours: Int, minutes: Int, seconds: Int) {
        let currentDate = Date().timeIntervalSince1970
        let remainingTime = max(0, item.dateTime - currentDate)

        let hours = Int(remainingTime / 3600)
        let minutes = Int((remainingTime.truncatingRemainder(dividingBy: 3600)) / 60)
        let seconds = Int(remainingTime.truncatingRemainder(dividingBy: 60))

        return (hours, minutes, seconds)
    }

    private func locationChecker(item: UserTask) {
        if item.dateTime == Date().timeIntervalSince1970 {
            viewModel.toggleIsComplete(item: item)
        }
        
        print("iwascalled")
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
    ), contentChanged: .constant(false))
}
