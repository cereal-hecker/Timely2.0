//
//  EventCard.swift
//  Timely2.0
//
//  Created by Riya Batla on 28/01/24.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import MapKit

struct EventCard: View {
    
    let event : UserTask
    @State private var locationName: String = "Loading..."
    
    var body: some View {
        HStack(alignment: .top) {
            Circle()
                .fill(Color.white)
                .frame(width: 20, height: 20)
                .offset(y: 15)
            HStack {
                VStack(alignment: .leading) {
                    HStack{
                        Text(formatDate(event.dateTime, format: "hh:mm a"))
                            .font(.callout)
                            .bold()
                        Spacer()
                        Text("\(formatEarlyTime(event.earlyTime))")
                            .font(.footnote)
                    }
                    Text(event.venue)
                        .font(.callout)
                    Text("\(locationName)")
                        .font(.footnote)
                    
                    HStack{
                        ForEach(event.tags, id: \.self) { tag in
                            HStack {
                                Text(tag)
                                Button(action: {
                                    // Replace this with the intended action
                                }) {
                                    Image(systemName: "multiply")
                                }
                            }
                            .font(.footnote)
                            .padding(5)
                            .background(Color.blue)
                            .cornerRadius(5)
                        }
                    }
                    
                }
                
                .padding()
                
                Spacer()
                
            }
            .frame(maxWidth: .infinity)
            .foregroundColor(.white)
            .background(Color.grey2)
            .cornerRadius(12)
        }
        .padding()
        .onAppear {
            fetchLocationDetails(location: CLLocationCoordinate2D(latitude: event.location.latitude, longitude: event.location.longitude)) { details in
                self.locationName = details
            }
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
    
    
    private func fetchLocationDetails(location: CLLocationCoordinate2D, completion: @escaping (String) -> Void) {
        let location = CLLocation(latitude: location.latitude, longitude: location.longitude)
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let placemark = placemarks?.first {
                var details: [String] = []
                
                if let name = placemark.name {
                    details.append("At: \(name)")
                }
                if let thoroughfare = placemark.thoroughfare {
                    details.append("Thoroughfare: \(thoroughfare)")
                }
                if let locality = placemark.locality {
                    details.append("\(locality)")
                }
                
                let fullDetails = details.joined(separator: "\n")
                completion(fullDetails)
            } else {
                completion("Unknown Location")
            }
        }
    }
}

#Preview {
    EventCard(event: .init(
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

