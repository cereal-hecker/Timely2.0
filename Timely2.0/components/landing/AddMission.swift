//
//  AddMission.swift
//  Timely2.0
//
//  Created by Riya Batla on 29/01/24.
//

import SwiftUI
import FirebaseAuth

struct AddMission: View {
    @State private var isSheetPresented = false
    
    var body: some View {
        ZStack(alignment: .trailing) {
            HStack {
                Button{
                    isSheetPresented.toggle()
                }label:{
                    Image(systemName: "plus")
                        .padding()
                        .background(.primarypink)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                }
            }
            .sheet(isPresented: $isSheetPresented ) {
                
                NavigationView {
                    MissionSheet(isSheetPresented: $isSheetPresented)
                        .background(.grey1)
                        .navigationBarItems(
                            trailing:  Button(action:{isSheetPresented.toggle()}){
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.grey7)
                            }
                        )
                        .environment(\.colorScheme, .dark)
                }
                .onAppear {
                    
                }
            }
        }
    }
}

#Preview {
    AddMission()
}

struct CalenderTask: View {
    @State private var isSheetPresented = false
    
    var body: some View {
        ZStack(alignment: .trailing) {
            HStack {
                Button{
                    isSheetPresented.toggle()
                }label:{
                    Image(systemName: "calendar")
                        .padding()
                        .background(.primarypink)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                }
            }
            .sheet(isPresented: $isSheetPresented ) {
                
                NavigationView {
                    CalendarView(userId: Auth.auth().currentUser?.uid ?? "")
                        .background(.grey1)
                        .navigationBarItems(
                            trailing:  Button(action:{isSheetPresented.toggle()}){
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.grey7)
                            }
                        )
                }
                .environment(\.colorScheme, .dark)
            }
        }
    }
}
