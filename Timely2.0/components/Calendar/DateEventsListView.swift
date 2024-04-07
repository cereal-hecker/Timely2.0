//
//  DateView.swift
//  Timely2.0
//
//  Created by user2 on 07/04/24.
//

import SwiftUI
import Firebase
import CoreLocation

struct DaysEventsListView: View {
    @Binding var dateSelected: Date
    @State var tasks : [UserTask]
    
    var body: some View {
        NavigationStack {
            Group {
                let foundEvents = tasks
                    List {
                        ForEach(filteredTasks) { task in
                            ListViewRow(task: task)
                                .listRowBackground(Color.grey2)
                        }
                    }
                
            }
        }
    }
    var filteredTasks: [UserTask] {
            return tasks.filter { task in
                let taskDate = Date(timeIntervalSince1970: task.dateTime)
                return Calendar.current.isDate(taskDate, inSameDayAs: dateSelected)
            }
        }
}


struct ListViewRow: View {
    let task: UserTask
    @State private var locationName: String = "Loading..."
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    VStack(alignment: .leading) {
                        HStack{
                            Text(formatDate(task.dateTime, format: "hh:mm a"))
                                .font(.callout)
                                .bold()
                            Spacer()
                            Text("\(formatEarlyTime(task.earlyTime))")
                                .font(.footnote)
                        }
                        Text(task.venue)
                            .font(.callout)
                        Text("\(task.location)")
                            .font(.footnote)
                        
                        
                    }
                    
                    .padding()
                    
                    Spacer()
                    
                }
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .background(Color.grey2)
                .cornerRadius(12)
            }
        }
        .onAppear {
            fetchLocationDetails(location: CLLocationCoordinate2D(latitude: task.location.latitude, longitude: task.location.longitude)) { details in
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

#Preview{
        ListViewRow(task: .init(
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
