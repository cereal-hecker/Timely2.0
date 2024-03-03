//
//  TestUi.swift
//  Timely2.0
//
//  Created by Riya Batla on 29/01/24.
//

import SwiftUI
import MapKit
import LocationPicker
import FirebaseAuth
import Firebase
import FirebaseFirestore

enum AppMode: String, CaseIterable {
    case online = "Online"
    case offline = "Physical"
}

enum RepeatMode: String, CaseIterable {
    case never = "Never"
    case daily = "Daily"
    case weekly = "Weekly"
}

struct TestUi: View {
    @State private var isSheetPresented = true
    
    var body: some View {
        VStack {
            Button("Add Mission") {
                isSheetPresented.toggle()
            }
        }
        .sheet(isPresented: $isSheetPresented) {
            NavigationView {
                MissionSheet()
                    .background(Color.grey1)
                    .foregroundColor(.white)
                    .navigationBarItems(
                        trailing: Button(action: {
                            isSheetPresented.toggle()
                        }) {
                            Image(systemName: "xmark.circle.fill")
                        }
                    )
                    .navigationBarTitle("Mission")
                    .foregroundColor(.white)
                    .environment(\.colorScheme, .dark)
            }
        }
    }
}


final class MissionSheetViewModel: ObservableObject{
    @Published var textInput = "iOS Bootcamp"
    
    init () {}
    
    func save() {
        guard canSave else {
            return
        }
        // Get current User Id
        guard let uId = Auth.auth().currentUser?.uid else {
            return
        }
        
        // Create Model
        let newId = UUID().uuidString
        let newTask = UserTask(id: newId, venue: textInput, dateTime: Date().timeIntervalSince1970, category: "String", isCompleted: false)
        
        // Save Model
        let db = Firestore.firestore()
        db.collection("user").document(uId).collection("tasks").document(newId).setData(newTask.asDictionary())
        
    }
    
    var canSave: Bool {
        guard !textInput.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        return true
    }
    
}

struct MissionSheet: View {
    @StateObject var viewModel = MissionSheetViewModel()
//    @State private var selectedDate = Date()
//    @State private var selectedTime = Date()
    @State private var selectedMode: AppMode = .online
    @State private var selectedRepeat: RepeatMode = .never
    @State private var coordinates = CLLocationCoordinate2D(latitude: 12.82318919, longitude: 80.04440627)
    @State private var showSheet = false
    @State private var showTagsDropdown = false
    @State private var selectedTag: String?
    @State private var tags: [String] = ["SwiftUI", "iOS", "Coding"]
    @State private var newTag: String = ""

    @State private var date = Date()
    let dateRange: ClosedRange<Date> = {        let calendar = Calendar.current
        let startComponents = DateComponents(year: 2021, month: 1, day: 1)
        let endComponents = DateComponents(year: 2021, month: 12, day: 31, hour: 23, minute: 59, second: 59)
        return calendar.date(from:startComponents)!
            ...
            calendar.date(from:endComponents)!
    }()
    
    var body: some View {
        VStack {
            Form {
                Button{
                    viewModel.save()
                }label:{
                    Text("SAVE")
                }
                Section(header: Text("Venue")) {
                    TextField("Enter text", text: $viewModel.textInput)
                }

                Section(header: Text("Date and time")) {
                    DatePicker(
                        "Pick a date",
                        selection: $date,
                        in: dateRange,
                        displayedComponents: [.date, .hourAndMinute]
                    )
                }.padding(.vertical, 10)

                Section(header: Text("Location Selection")) {
                    HStack {
                        Text("Tech Park SRM")
                        Spacer()
                        Button("Select location") {
                            self.showSheet.toggle()
                        }
                    }
                }
                Section(header: Text("Repeat")) {
                    List {
                        Picker("Repeat When", selection: $selectedRepeat) {
                            ForEach(RepeatMode.allCases, id: \.self) { mode in
                                Text(mode.rawValue)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                }
                Section(header: Text("Mode Selection")) {
                    List {
                        Picker("Select Mode", selection: $selectedMode) {
                            ForEach(RepeatMode.allCases, id: \.self) { mode in
                                Text(mode.rawValue)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                }

                Section(header: Text("Tags")) {
                                    DisclosureGroup("Tags", isExpanded: $showTagsDropdown) {
                                        HStack {
                                            ForEach(tags, id: \.self) { tag in
                                                Text(tag)
                                                    .padding(.horizontal, 8)
                                                    .padding(.vertical, 4)
                                                    .background(Color.blue)
                                                    .cornerRadius(8)
                                                    .foregroundColor(.white)
                                                    .onTapGesture {
                                                        // Select the tapped tag
                                                        selectedTag = tag
                                                        showTagsDropdown.toggle() // Close the dropdown after selecting a tag
                                                    }
                                            }

                                            Button(action: {
                                                // Remove the last tag when the button is tapped
                                                if !tags.isEmpty {
                                                    tags.removeLast()
                                                }
                                            }) {
                                                Image(systemName: "xmark.circle.fill")
                                                    .foregroundColor(.red)
                                            }
                                        }

                                        List {
                                            ForEach(tags, id: \.self) { tag in
                                                Text(tag)
                                                    .onTapGesture {
                                                        // Select the tapped tag
                                                        selectedTag = tag
                                                        showTagsDropdown.toggle() // Close the dropdown after selecting a tag
                                                    }
                                            }
                                        }
                                        .listStyle(PlainListStyle())
                                        .frame(height: 150)
                                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                                    }
                                }
                            }
                            .sheet(isPresented: $showSheet) {
                                LocationPicker(instructions: "Tap to select coordinates", coordinates: $coordinates, dismissOnSelection: true)
                            }
                            .padding(.vertical)
                        }
                    }

    private func dismissSheet() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            presentationMode.wrappedValue.dismiss()
        }
    }
    @Environment(\.presentationMode) var presentationMode
}


#Preview {
    TestUi()
}
