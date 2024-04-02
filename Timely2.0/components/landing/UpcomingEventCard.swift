//
//  UpcomingEventCard.swift
//  Timely2.0
//
//  Created by Riya Batla on 28/01/24.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore
import MapKit

class UpcomingEventCardManager: ObservableObject {
    @Published var remainingTime = (hours: 0, minutes: 0, seconds: 0)
    
    init() {}
}



struct UpcomingEventCard: View {
    @ObservedObject private var viewModel = UpcomingEventCardManager()
    @EnvironmentObject var locationManager : LocationManager
    var task: UserTask
    @State private var timer: Timer?
    @State private var eta: String = "Calculating ETA..."
    @State private var etaToggle: Bool = false
    @State private var deleteToggle: Bool = false
    init(task: UserTask) {
        self.task = task
        viewModel.remainingTime = calculateRemainingTime(item: task)
    }
    
    var body: some View {
            HStack{
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
                        Text(formatDate(task.dateTime, format: "hh:mm a"))
                            .font(.title2)
                            .bold()
                    }
                    if etaToggle {
                        Text("ETA: \(eta)")
                            .font(.caption)
                    } else {
                        Text("Early by: \(formatEarlyTime(task.earlyTime))")
                            .font(.caption)
                    }
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text(task.venue)
                        .font(.title2)
                        .bold()
                        .truncationMode(.tail)
                    Text(task.venue)
                        .font(.caption)
                        .italic()
                        .truncationMode(.tail)
                }
            }
            .padding(5)
            .padding()
            .frame(height: 110)
            .background(Color.grey2)
            .foregroundColor(.white)
            .onAppear{
                timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                    updateRemainingTime(item: task)
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
            
        } else {
            let numericValue = extractNumber(from: item.earlyTime)
            if viewModel.remainingTime.minutes <= Int(numericValue ?? 0) &&
                viewModel.remainingTime.hours == 0 {
                calculateETA()
                etaToggle=true
            }
        }
    }
    
    // MARK: extract number for earlytime
    func extractNumber(from string: String) -> Int? {
        var numberString = ""
        
        for char in string {
            if let number = Int(String(char)) {
                numberString.append(String(number))
            } else {
                break
            }
        }
        
        return Int(numberString)
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
        let destination = CLLocationCoordinate2D(latitude: item.location.latitude, longitude: item.location.longitude)
        let result = checkDistance(from: destination)
        
        if result {
            // MARK: mark the task complete
            UserManager.shared.toggleIsComplete(item: item)
            
            // MARK: Updating the currentHp
            UserManager.shared.updateUserLevel(Hp: 100)
            print("toggle was complete")
        } else {
            UserManager.shared.updateUserLevel(Hp: -50)
        }
    }
    
    // MARK: Distance Checker with location access
    func checkDistance(from destination: CLLocationCoordinate2D) -> Bool {
        let destinationToReach = CLLocation(latitude: destination.latitude, longitude: destination.longitude)
        let currentLocation = CLLocation(latitude: locationManager.location?.coordinate.latitude ?? 0.0, longitude: locationManager.location?.coordinate.longitude ?? 0.0)
        
        // MARK: Radius of location acceptance
        let radius: CLLocationDistance = 100.0
        
        let distance = destinationToReach.distance(from: currentLocation)
        
        print("Earlier location: \(destinationToReach)")
        print("Current location: \(currentLocation.coordinate)")
        print("Distance: \(distance)")
        
        if distance <= radius {
            print("The locations are within \(radius) meters of each other.")
            return true
        } else {
            print("The locations are not within \(radius) meters of each other.")
            return false
        }
    }
    
    // MARK: Eta calculation
    private func calculateETA() {
        let currentLocation = CLLocationCoordinate2D(latitude: locationManager.location?.coordinate.latitude ?? 0.0, longitude: locationManager.location?.coordinate.longitude ?? 0.0)
        let targetCoordinate = CLLocationCoordinate2D(latitude: task.location.latitude, longitude: task.location.longitude)
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: currentLocation))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: targetCoordinate))
        request.transportType = .automobile // Change to .walking or .transit if needed
        
        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            guard let response = response else {
                if let error = error {
                    print("Error calculating ETA: \(error.localizedDescription)")
                }
                return
            }
            
            let eta = response.routes.first?.expectedTravelTime ?? 0
            let formatter = DateComponentsFormatter()
            formatter.unitsStyle = .short
            formatter.allowedUnits = [.hour, .minute]
            
            self.eta = formatter.string(from: eta) ?? "N/A"
        }
    }
    
}

//#Preview {
//    UpcomingEventCard(
//        item: .init(
//            id: "123",
//            venue: "IOS Bootcamp",
//            dateTime: Date().timeIntervalSince1970,
//            location: GeoPoint(latitude: 12.82318919, longitude: 80.04440627),
//            repeatTask: "once",
//            earlyTime: "min10",
//            tags: ["important"],
//            isCompleted: false))
//}
