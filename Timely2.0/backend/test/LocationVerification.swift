//
//  LocationVerification.swift
//  Timely
//
//  Created by user2 on 27/02/24.
//

import SwiftUI
import MapKit
import CoreLocation
import _CoreLocationUI_SwiftUI

struct LocationVerification: View {
    @StateObject private var viewModel = ContentViewModel()

    var body: some View {
        VStack {
            Text("\(Date())")
            ZStack(alignment: .bottom) {
                Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
                    .tint(.pink)
                
                LocationButton(.currentLocation) {
                    // Handle button tap if needed
                }
                .labelStyle(.iconOnly)
            }
        }
    }
}

final class ContentViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
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
    
    func requestAllowPermission() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func checkDistance(from earlierLocation: CLLocationCoordinate2D) {
        let theEarlyLocation = CLLocation(latitude: earlierLocation.latitude, longitude: earlierLocation.longitude)
        let currentLocation = CLLocation(latitude: region.center.latitude, longitude: region.center.longitude)

        let radius: CLLocationDistance = 100.0
        let distance = theEarlyLocation.distance(from: currentLocation)

        print("Earlier location: \(earlierLocation)")
        print("Current location: \(currentLocation.coordinate)")
        print("Distance: \(distance)")

        if distance <= radius {
            print("The locations are within \(radius) meters of each other.")
        } else {
            print("The locations are not within \(radius) meters of each other.")
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latestLocation = locations.first else { return }

        DispatchQueue.main.async {
            self.region = MKCoordinateRegion(
                center: latestLocation.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
            
            // Access the mocuser location
            let mocuserLocation = location.mocuser
            let mark = CLLocationCoordinate2D(latitude: mocuserLocation.latitude, longitude: mocuserLocation.longitude)
            
            // Call checkDistance with mocuser location
            self.checkDistance(from: mark)

            print("Region latitude: \(self.region.center.latitude)")
            print("Region longitude: \(self.region.center.longitude)")
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error: \(error.localizedDescription)")
    }
}

struct location {
    let id: String
    let latitude: Double
    let longitude: Double
}

extension location {
    static var mocuser = location(id: UUID().uuidString, latitude: 37.785834, longitude: -122.406417)
}

#Preview{
    LocationVerification()
}
