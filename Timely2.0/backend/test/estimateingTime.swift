import SwiftUI
import MapKit
import Firebase
struct EtatestView: View {
    @State private var userLocation: CLLocation?
    @State private var targetLocation: CLLocationCoordinate2D?
    @State private var eta: String = "Calculating ETA..."
    @EnvironmentObject var locationManager: LocationManager
    var item: UserTask
    init(item: UserTask) {
        self.item = item
    }
    var body: some View {
        VStack {
            Text("ETA: \(eta)")
                .padding()
            
            
            
            Button("Calculate ETA") {
                calculateETA()
            }
            .padding()
        }
    }
    
    private func calculateETA() {
        // Replace the following coordinates with your actual user and target coordinates
        let currentLocation = CLLocationCoordinate2D(latitude: locationManager.location?.coordinate.latitude ?? 0.0, longitude: locationManager.location?.coordinate.longitude ?? 0.0)
        let targetCoordinate = CLLocationCoordinate2D(latitude: item.location.latitude, longitude: item.location.longitude)
        
        let targetLocation = CLLocation(latitude: targetCoordinate.latitude, longitude: targetCoordinate.longitude)
        
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

struct EtatestView_Previews: PreviewProvider {
    static var previews: some View {
        EtatestView(
            item: .init(
                id: "123",
                venue: "IOS Bootcamp",
                dateTime: Date().timeIntervalSince1970,
                location: GeoPoint(latitude: 12.82318919, longitude: 80.04440627),
                repeatTask: "once",
                earlyTime: "min10",
                tags: ["important"],
                isCompleted: false))
    }
}


//
//
////
////  TestUi.swift
////  Timely2.0
////
////  Created by Riya Batla on 29/01/24.
////
//
//import SwiftUI
//import MapKit
//import LocationPicker
//import FirebaseAuth
//import Firebase
//import FirebaseFirestore
//
//enum earlyTimeMode: String, CaseIterable {
//    case min10 = "10 Min"
//    case min20 = "20 Min"
//    case min30 = "30 Min"
//    case min50 = "50 Min"
//    case min60 = "60 Min"
//    
//    var formattedString: String {
//        let minutes = self.rawValue.components(separatedBy: CharacterSet.decimalDigits.inverted)
//            .compactMap { Int($0) }
//            .first ?? 0
//        
//        return "early by \(minutes) min"
//    }
//}
//
//enum RepeatMode: String, CaseIterable {
//    case once = "Once"
//    case daily = "Daily"
//    case weekly = "Weekly"
//}
//
//struct TestUi: View {
//    @State private var isSheetPresented = true
//    
//    var body: some View {
//        VStack {
//            Button("Add Mission") {
//                isSheetPresented.toggle()
//            }
//        }
//        .sheet(isPresented: $isSheetPresented) {
//            NavigationView {
//                MissionSheet(isSheetPresented: $isSheetPresented)
//                    .background(Color.grey1)
//                    .foregroundColor(.white)
//                    .navigationBarItems(
//                        trailing: Button(action: {
//                            isSheetPresented.toggle()
//                        }) {
//                            Image(systemName: "xmark.circle.fill")
//                        }
//                    )
//                    .environment(\.colorScheme, .dark)
//            }
//        }
//    }
//}
//
//
//final class MissionSheetViewModel: ObservableObject{
//    @Published var textInput = ""
//    @Published var selectedRepeat: RepeatMode = .once
//    @Published var selectedEarlyTime: earlyTimeMode = .min10
//    @Published var coordinates = CLLocationCoordinate2D(latitude: 12.82318919, longitude: 80.04440627)
//    @Published var showSheet = false
//    @Published var showTagsDropdown = false
//    @Published var selectedTag: String?
//    @Published var tags: [String] = []
//    @Published var recentTags: [String] = UserDefaults.standard.stringArray(forKey: "RecentTags") ?? []
//    @Published var date = Date()
//    
//    init () {}
//    
//    func save() {
//        guard canSave else {
//            return
//        }
//        // Get current User Id
//        guard let uId = Auth.auth().currentUser?.uid else {
//            return
//        }
//        
//        // Create Model
//        let newId = UUID().uuidString
//        let newTask = UserTask(id: newId, venue: textInput, dateTime: date.timeIntervalSince1970, location: GeoPoint(latitude: coordinates.latitude, longitude: coordinates.longitude), repeatTask: selectedRepeat.rawValue, earlyTime: selectedEarlyTime.rawValue, tags: tags, isCompleted: false)
//        
//        guard let userTask = try? Firestore.Encoder().encode(newTask) else {return}
//        // Save Model
//        let db = Firestore.firestore()
//        db.collection("customer").document(uId).collection("tasks").document(newId).setData(userTask)
//    }
//    
//    var canSave: Bool {
//        guard !textInput.trimmingCharacters(in: .whitespaces).isEmpty else {
//            return false
//        }
//        return true
//    }
//}
//
//struct MissionSheet: View {
//    @StateObject var viewModel = MissionSheetViewModel()
//    
//    @Binding var isSheetPresented: Bool
//    @State private var showSheet = false
//    @State private var showTagsDropdown = false
//    @State private var selectedTag: String?
//    @State private var newTag: String = ""
//    @State private var locationName: String = "Select Location"
//    
//    let dateRange: ClosedRange<Date> = {
//        let calendar = Calendar.current
//        let startComponents = DateComponents(year: 2021, month: 1, day: 1)
//        let endComponents = DateComponents(year: 2021, month: 12, day: 31, hour: 23, minute: 59, second: 59)
//        return calendar.date(from: startComponents)! ... calendar.date(from: endComponents)!
//    }()
//    
//    var body: some View {
//        VStack {
//            Text("Add Mission")
//                .font(.title)
//                .bold()
//                .offset(x:-100)
//            Form {
//                Section(header: Text("Venue")) {
//                    TextField("Enter the Venue", text: $viewModel.textInput)
//                }
//                
//                Section(header: Text("Date and time")) {
//                    DatePicker(
//                        "Pick a date",
//                        selection: $viewModel.date,
//                        in: Date()...,
//                        displayedComponents: [.date, .hourAndMinute]
//                    )
//                }
//                .padding(.vertical, 10)
//                
//                Section(header: Text("Location Selection")) {
//                    HStack {
//                        Text(locationName)
//                        Spacer()
//                        Button("Select location") {
//                            self.showSheet.toggle()
//                        }
//                    }
//                }
//                Section(header: Text("Repeat")) {
//                    List {
//                        Picker("Repeat When", selection: $viewModel.selectedRepeat) {
//                            ForEach(RepeatMode.allCases, id: \.self) { mode in
//                                Text(mode.rawValue)
//                            }
//                        }
//                        .pickerStyle(MenuPickerStyle())
//                    }
//                }
//                Section(header: Text("Early by")) {
//                    List {
//                        Picker("Select Time", selection: $viewModel.selectedEarlyTime) {
//                            ForEach(earlyTimeMode.allCases, id: \.self) { mode in
//                                Text(mode.rawValue)
//                            }
//                        }
//                        .pickerStyle(MenuPickerStyle())
//                    }
//                }
//                
//                Section(header: Text("Tags")) {
//                    DisclosureGroup("Tags", isExpanded: $showTagsDropdown) {
//                        VStack {
//                            HStack {
//                                TextField("Enter Tag", text: $newTag)
//                                Button(action: {
//                                    if !newTag.isEmpty {
//                                        viewModel.recentTags.append(newTag)
//                                        UserDefaults.standard.set(viewModel.recentTags, forKey: "RecentTags")
//                                        newTag = ""
//                                    }
//                                }) {
//                                    Text("Add")
//                                }
//                            }
//                            
//                            HStack {
//                                ForEach(viewModel.recentTags, id: \.self) { tag in
//                                    Text(tag)
//                                        .padding(.horizontal, 8)
//                                        .padding(.vertical, 4)
//                                        .background(Color.blue)
//                                        .cornerRadius(8)
//                                        .foregroundColor(.white)
//                                        .onTapGesture {
//                                            // Select the tapped tag
//                                            viewModel.selectedTag = tag
//                                            showTagsDropdown.toggle()
//                                        }
//                                }
//                                Button(action: {
//                                    if !viewModel.recentTags.isEmpty {
//                                        viewModel.recentTags.removeLast()
//                                        UserDefaults.standard.set(viewModel.recentTags, forKey: "RecentTags")
//                                    }
//                                }) {
//                                    Image(systemName: "xmark.circle.fill")
//                                        .foregroundColor(.red)
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//            .sheet(isPresented: $showSheet) {
//                LocationPicker(instructions: "Tap to select coordinates", coordinates: $viewModel.coordinates, dismissOnSelection: true)
//                    .onDisappear {
//                        fetchLocationDetails(location: viewModel.coordinates) { details in
//                            self.locationName = details
//                            print("LocationView Called")
//                            print(locationName)
//                        }
//                    }
//            }
//            .padding(.vertical)
//        }
//        Button{
//            viewModel.save()
//            isSheetPresented.toggle()
//        }label:{
//            Text("SAVE")
//                .background{
//                    RoundedRectangle(cornerRadius: 10)
//                        .foregroundColor(.blue)
//                        .frame(width: 100,height: 40)
//                }
//                .foregroundStyle(Color.white)
//        }
//        .padding(.bottom,40)
//        
//    }
//    
//    private func fetchLocationDetails(location: CLLocationCoordinate2D, completion: @escaping (String) -> Void) {
//        let location = CLLocation(latitude: location.latitude, longitude: location.longitude)
//        let geocoder = CLGeocoder()
//        
//        geocoder.reverseGeocodeLocation(location) { placemarks, error in
//            if let placemark = placemarks?.first {
//                var details: [String] = []
//                
//                if let name = placemark.name {
//                    details.append("Name: \(name)")
//                }
//                if let thoroughfare = placemark.thoroughfare {
//                    details.append("Thoroughfare: \(thoroughfare)")
//                }
//                if let locality = placemark.locality {
//                    details.append("Locality: \(locality)")
//                }
//                
//                let fullDetails = details.joined(separator: "\n")
//                completion(fullDetails)
//            } else {
//                completion("Unknown Location")
//            }
//        }
//    }
//    private func dismissSheet() {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//            presentationMode.wrappedValue.dismiss()
//        }
//    }
//    @Environment(\.presentationMode) var presentationMode
//}
//
//
//#Preview {
//    TestUi()
//}
