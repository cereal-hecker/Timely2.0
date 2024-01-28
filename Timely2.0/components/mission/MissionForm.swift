////
////  MissionForm.swift
////  Timely2.0
////
////  Created by Riya Batla on 29/01/24.
////
//
////import SwiftUI
////
////struct MissionForm: View {
////    var body: some View {
////        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
////    }
////}
////
////#Preview {
////    MissionForm()
////}
//
//import SwiftUI
//import MapKit
//import LocationPicker
//
//enum AppMode: String, CaseIterable {
//    case online = "Online"
//    case offline = "Physical"
//}
//
//struct TestUi: View {
//    @State private var isSheetPresented = false
//    
//    var body: some View {
//        VStack {
//            Button("Add Mission") {
//                isSheetPresented.toggle()
//            }
//        }
//        .sheet(isPresented: $isSheetPresented) {
//            NavigationView {
//                MissionForm()
//                    .navigationBarItems(
//                        trailing:  Button(action:{isSheetPresented.toggle()}){
//                            Image(systemName: "xmark.circle.fill")
//                        }
//                    ) .navigationBarTitle("Mission")
//            }
//        }
//    }
//}
//
//struct MissionForm: View {
//    @State private var textInput = "iOS Bootcamp"
//    @State private var selectedDate = Date()
//    @State private var selectedTime = Date()
//    @State private var selectedMode: AppMode = .online
//    @State private var coordinates = CLLocationCoordinate2D(latitude: 12.82318919, longitude: 80.04440627)
//    @State private var showSheet = false
//    
//    var body: some View {
//        
//        VStack {
//            Form {
//                Section(header: Text("Venue")) {
//                    TextField("Enter text", text: $textInput) .foregroundColor(.white)
//                }
//                .listRowBackground(Color.accent)
//                Section(header: Text("Date and time Selection")) {
//                    DatePicker(
//                        selection: $selectedDate,
//                        in: Date()...,
//                        displayedComponents: [.date],
//                        label: { Text("Select a date") .foregroundColor(.white)
//                            .foregroundColor(.white)}
//                    )
//                    DatePicker(
//                        selection: $selectedTime,
//                        in: Date()...,
//                        displayedComponents: [.hourAndMinute],
//                        label: { Text("Select a time") .foregroundColor(.white) }
//                    )
//                }.padding(.vertical,10)
//                    .listRowBackground(Color.accent)
//                
//                Section(header: Text("Location Selection")){
//                    HStack{
//                        Text("Tech Park SRM") .foregroundColor(.white)
//                        Spacer()
//                        Button("Select location") {
//                            self.showSheet.toggle()
//                        }
//                    }
//                }
//                .listRowBackground(Color.accent)
//                Section(header: Text("Mode Selection")) {
//                    List {
//                        Picker("Select Mode", selection: $selectedMode) {
//                            ForEach(AppMode.allCases, id: \.self) { mode in
//                                Text(mode.rawValue)
//                            }
//                            .foregroundColor(.white)
//                        }
//                        .pickerStyle(MenuPickerStyle())
//                    } .foregroundColor(.white)
//                }
//                .listRowBackground(Color.accent)
//            }
////            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
////            .background(Color.accent)
////            .background(Color.accent)
//            .cornerRadius(20)
//            .edgesIgnoringSafeArea(.bottom)
//            .scrollContentBackground(.hidden)
//            .sheet(isPresented: $showSheet) {
//                LocationPicker(instructions: "Tap to select coordinates", coordinates: $coordinates, dismissOnSelection: true)
//            }
//            .accentColor(.white)
////            .foregroundColor(Color.background)
////            .background(.accent)
//           
//        }
//        .padding(.vertical)
////        .background(Color.background)
//            
//        
//    }
//    
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
//
