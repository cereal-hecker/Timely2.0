//
//  Schedule.swift
//  Timely2.0
//
//  Created by Riya Batla on 28/01/24.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

class ScheduleViewModel: ObservableObject {
    @State var userId: String
    
    init() {
        guard let userId = Auth.auth().currentUser?.uid else {
            // MARK: remove the uid add for preview
            self.userId = "Vb6MhTUkUjfsh42tNZPAR0zWL8F3"
            return
        }
        self.userId = userId
    }
    
}

struct Schedule: View {
    @StateObject var viewModel = ScheduleViewModel()
    @EnvironmentObject var weekStore: WeekStore
    @State private var selectedDate = Date()
    @State private var currentSelectedTag : String = "All"
    var body: some View {
        VStack(alignment: .leading){
            VStack(alignment: .leading, spacing: 0){
                HStack{
                    VStack(alignment:.leading){
                        Text(weekStore.selectedDate.monthYYYY())
                            .textCase(.uppercase)
                            .foregroundColor(.grey7)
                            .font(.caption)
                            .bold()
                        Text(weekStore.selectedDate.formatted(.dateTime .weekday(.wide)))
                            .foregroundColor(.white)
                            .font(.title)
                            .bold()
                    }
                    HStack {
                        Spacer()
                        Button(action: {
                            weekStore.selectToday()
                        }) {
                            Text("Jump")
                                .foregroundColor(.blue)
                                .font(.system(size: 14))
                        }
                        DatePicker(
                            "",
                            selection: $selectedDate,
                            displayedComponents: [.date]
                        )
                        .frame(width: 120)
                        .foregroundColor(.white)
                        .onChange(of: selectedDate) {
                            weekStore.select(date: selectedDate)
                        }
                    }
            }
                .padding(.horizontal)
                
            // MARK: Horizontal Weeks View
                WeeksTabView() { week in
                    WeekView(week: week)
                }
                .padding(.top,8)
        }
            ZStack(alignment: .top){
                UnevenRoundedRectangle(cornerRadii: .init(
                    topLeading: 50,
                    topTrailing: 50),
                                       style: .continuous)
                .foregroundColor(.grey1)
                VStack{
                    
                    // MARK: Event Lists
                    EventList(userId: viewModel.userId)
                }
            }
            .padding(2)
        }
        .overlay(
            AddMission()
                .position(CGPoint(x: 340.0, y: 640.0))
        )
        .background(.black)
    }
}

struct Schedule_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ScheduleViewModel()
        let weekStore = WeekStore() // Create an instance of WeekStore
        return Schedule()
            .environmentObject(weekStore) // Provide WeekStore to the environment
    }
}
