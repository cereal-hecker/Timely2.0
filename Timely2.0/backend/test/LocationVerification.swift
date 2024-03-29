////
////  LocationVerification.swift
////  Timely
////
////  Created by user2 on 27/02/24.
////
//
//import SwiftUI
//import MapKit
//import CoreLocation
//import _CoreLocationUI_SwiftUI
//
//final class LocationVerificationViewManager: NSObject, ObservableObject, CLLocationManagerDelegate {
//    @Published var region = MKCoordinateRegion(
//        center: CLLocationCoordinate2D(latitude: 20, longitude: 20),
//        span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
//    )
//
//    let locationManager = CLLocationManager()
//
//    override init() {
//        super.init()
//        locationManager.delegate = self
//        requestAllowPermission()
//    }
//
//    // MARK: permission Request
//    func requestAllowPermission() {
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.startUpdatingLocation()
//    }
//    // MARK: Distance Checker
//    func checkDistance(from destination: CLLocationCoordinate2D) {
//
//        let destinationToReach = CLLocation(latitude: destination.latitude, longitude: destination.longitude)
//        let currentLocation = CLLocation(latitude: region.center.latitude, longitude: region.center.longitude)
//
//        // MARK: Radius of location acceptance
//        let radius: CLLocationDistance = 100.0
//
//        let distance = destinationToReach.distance(from: currentLocation)
//
//        print("Current location: \(currentLocation.coordinate)")
//        print("Distance: \(distance)")
//
//        if distance <= radius {
//            print("The locations are within \(radius) meters of each other.")
//        } else {
//            print("The locations are not within \(radius) meters of each other.")
//        }
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let latestLocation = locations.first else { return }
//
//        DispatchQueue.main.async {
//            self.region = MKCoordinateRegion(
//                center: latestLocation.coordinate,
//                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
//            )
//
//            // Access the mocuser location
//            let mocuserLocation = lcation.mocuser
//            let mark = CLLocationCoordinate2D(latitude: mocuserLocation.latitude, longitude: mocuserLocation.longitude)
//
//            // Call checkDistance with mocuser location
//            self.checkDistance(from: mark)
//
//            print("Region latitude: \(self.region.center.latitude)")
//            print("Region longitude: \(self.region.center.longitude)")
//        }
//    }
//
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print("Location error: \(error.localizedDescription)")
//    }
//}
//
//
//struct LocationVerificationView: View {
//    @StateObject private var viewModel = LocationVerificationViewManager()
//
//    var body: some View {
//        VStack {
//            Text("\(Date())")
//            Text("location")
//            ZStack(alignment: .bottom) {
//                LocationButton(.currentLocation) {
//                    // Handle button tap if needed
//                }
//                .labelStyle(.iconOnly)
//            }
//        }
//    }
//}
//
//
//struct lcation {
//    let id: String
//    let latitude: Double
//    let longitude: Double
//}
//
//extension lcation {
//    static var mocuser = lcation(id: UUID().uuidString, latitude: 37.785834, longitude: -122.406417)
//}
//
//#Preview{
//    LocationVerificationView()
//}

