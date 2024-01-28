//
//  TestUi.swift
//  Timely2.0
//
//  Created by Riya Batla on 29/01/24.
//

import SwiftUI
import MapKit
import LocationPicker

enum AppMode: String, CaseIterable {
    case online = "Online"
    case offline = "Physical"
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
                    .navigationBarTitleDisplayMode(.automatic)
                    .foregroundColor(.white)
                    .environment(\.colorScheme, .dark)
            }
        }
    }
}


struct MissionSheet: View {
    @State private var textInput = "iOS Bootcamp"
    @State private var selectedDate = Date()
    @State private var selectedTime = Date()
    @State private var selectedMode: AppMode = .online
    @State private var coordinates = CLLocationCoordinate2D(latitude: 12.82318919, longitude: 80.04440627)
    @State private var showSheet = false
    
    var body: some View {
        
        VStack {
                Text("Mission")
            Form {
                Section(header: Text("Venue")) {
                    TextField("Enter text", text: $textInput)
                }
                
                Section(header: Text("Date and time Selection")) {
                    DatePicker(
                        selection: $selectedDate,
                        in: Date()...,
                        displayedComponents: [.date],
                        label: { Text("Select a date") }
                    )
                    DatePicker(
                        selection: $selectedTime,
                        in: Date()...,
                        displayedComponents: [.hourAndMinute],
                        label: { Text("Select a time") }
                    )
                }.padding(.vertical,10)
                
                Section(header: Text("Location Selection")){
                    HStack{
                        Text("Tech Park SRM")
                        Spacer()
                        Button("Select location") {
                            self.showSheet.toggle()
                        }
                    }
                }
                
                Section(header: Text("Mode Selection")) {
                    List {
                        Picker("Select Mode", selection: $selectedMode) {
                            ForEach(AppMode.allCases, id: \.self) { mode in
                                Text(mode.rawValue)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                }
            }
            .sheet(isPresented: $showSheet) {
                LocationPicker(instructions: "Tap to select coordinates", coordinates: $coordinates, dismissOnSelection: true)
            }
           
        }.padding(.vertical)
            
        
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
