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
    
    init() {
        
    }
}


struct UpcomingEventCard: View {
    @ObservedObject private var viewModel = UpcomingEventCardManager()
    @ObservedObject private var locationVerificationModel: LocationVerificationViewModel
    var item: UserTask
    @State private var timer: Timer?
    
    init(item: UserTask, contentChanged: Binding<Bool>) {
        self.locationVerificationModel = LocationVerificationViewModel()
        self.item = item
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
                UserManager.shared.toggleIsComplete(item: item)
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
            
        }
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
        let result = locationVerificationModel.checkDistance(from: destination)
        
        if result {
            UserManager.shared.toggleIsComplete(item: item)
            
            // Updating the currentHp
            UserManager.shared.updateUserLevel(Hp: 100)
            print("toggle was complete")
            
        }else{
            UserManager.shared.updateUserLevel(Hp: 50)
            print("hp in updateUsedr")
            
        }
    }
    
}



#Preview {
    UpcomingEventCard(
        item: .init(
            id: "123",
            venue: "IOS Bootcamp",
            dateTime: Date().timeIntervalSince1970,
            location: GeoPoint(latitude: 12.82318919, longitude: 80.04440627),
            repeatTask: "once",
            earlyTime: "min10",
            tags: ["important"],
            isCompleted: false),
        contentChanged: .constant(false))
}

import MapKit
import CoreLocation
import _CoreLocationUI_SwiftUI

final class LocationVerificationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 20, longitude: 20),
        span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
    )
    
    let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
        requestAllowPermission()
    }
    
    // MARK: permission Request
    func requestAllowPermission() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    // MARK: Distance Checker
    func checkDistance(from destination: CLLocationCoordinate2D) -> Bool {
        let destinationToReach = CLLocation(latitude: destination.latitude, longitude: destination.longitude)
        let currentLocation = CLLocation(latitude: region.center.latitude, longitude: region.center.longitude)
        
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
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latestLocation = locations.first else { return }
        
        DispatchQueue.main.async {
            self.region = MKCoordinateRegion(
                center: latestLocation.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
            
            print("Region latitude: \(self.region.center.latitude)")
            print("Region longitude: \(self.region.center.longitude)")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error: \(error.localizedDescription)")
    }
}
