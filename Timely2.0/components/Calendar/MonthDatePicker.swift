//
//  MonthDatePicker.swift
//  Timely2.0
//
//  Created by user2 on 07/04/24.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

struct MonthDatePicker: View {
    @Binding var currentDate: Date
    var userId: String
    @FirestoreQuery var tasks: [UserTask]
    @State var currentMonth: Int = 0
    
    @State var displayEvent: Bool = false
    init(currentDate: Binding<Date>, userId: String){
        self._currentDate = currentDate
        self.userId = userId
        self._tasks = FirestoreQuery(collectionPath: "customer/\(userId)/tasks")
    }
    var body: some View {
        VStack(spacing: 35){
            let days: [String] = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]
            HStack(spacing:20){
                VStack(alignment: .leading, spacing: 20){
                    Text(extraDate()[1])
                        .font(.caption)
                        .fontWeight(.semibold)
                    
                    Text(extraDate()[0])
                        .font(.title.bold())
                    
                }
                Spacer()
                
                Button {
                    withAnimation{
                        currentMonth -= 1
                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .font((.title2))
                }
                Button {
                    withAnimation{
                        currentMonth += 1
                    }
                } label: {
                    Image(systemName: "chevron.right")
                        .font((.title2))
                }
            }
            .padding(.horizontal)
            
            HStack(spacing:0){
                ForEach(days,id: \.self){ day in
                    Text(day)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                }
            }
            
            let columns = Array(repeating: GridItem(.flexible()), count: 7)
            
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(extractDate()){ value in
                    CardView(value: value)
                        .background(
                            Capsule()
                                .fill(Color.grey1)
                                .padding(.horizontal,8)
                                .opacity(isSameDay(date1:value.date.timeIntervalSince1970 , date2: currentDate) ? 1 : 0)
                            )
                        .onTapGesture {
                            withAnimation{
                                currentDate = value.date
                                if tasks.first(where: {task in
                                    return isSameDay(date1: task.dateTime, date2: value.date)
                                }) != nil{
                                    displayEvent.toggle()
                                }
                            }
                        }
                        .sheet(isPresented: $displayEvent) {
                            DaysEventsListView(dateSelected: $currentDate, tasks : tasks)
                                .presentationDetents([.medium, .large])
                        }
                }
            }
        }
        .onChange(of: currentMonth){
            currentDate = getCurrentMonth()
        }
    }
    
    @ViewBuilder
    func CardView(value: DateValue) -> some View {
        VStack{
            if value.day != -1 {
                if let task = tasks.first(where: {task in
                    return isSameDay(date1: task.dateTime, date2: value.date)
                }){
                    Text("\(value.day)")
                        .font(.title3.bold())
                        .foregroundColor(isSameDay(date1: value.date.timeIntervalSince1970, date2: currentDate) ? .white : .primary)
                        .frame(maxWidth: .infinity)
                    Spacer()
                    Circle()
                        .fill(Color.pink)
                        .frame(width: 8,height: 8)
                    
                    Text(task.venue)
                }else{
                    Text("\(value.day)")
                        .font(.title3.bold())
                        .foregroundColor(isSameDay(date1: value.date.timeIntervalSince1970, date2: currentDate) ? .white : .primary)
                        .frame(maxWidth: .infinity)
                    Spacer()
                }
            }
        }
        .padding(.vertical,8)
        .frame(height: 60, alignment: .top)
    }
    
    func isSameDay(date1: TimeInterval, date2: Date) -> Bool {
        // Convert TimeInterval to Date
        let dateTime = Date(timeIntervalSince1970: date1)
        
        // Extract components of both dates
        let calendar = Calendar.current
        let components1 = calendar.dateComponents([.year, .month, .day], from: dateTime)
        let components2 = calendar.dateComponents([.year, .month, .day], from: date2)
        
        // Compare year, month, and day componentss
        return components1.year == components2.year &&
               components1.month == components2.month &&
               components1.day == components2.day
    }

    
    func extraDate() -> [String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM YYYY"
        
        let date = formatter.string(from: currentDate)
        
        return date.components(separatedBy: " ")
    }
    
    func getCurrentMonth() -> Date {
        let calendar = Calendar.current
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date()) else {
            return Date()
        }
        return currentMonth
    }
    
    func extractDate() -> [DateValue] {
        let calendar = Calendar.current
        
        let currentMonth = getCurrentMonth()
        var days = currentMonth.getAllDates().compactMap { date -> DateValue in
            let day = calendar.component(.day, from: date)
            
            return DateValue(day: day, date: date)
        }
        let firstWeekDay = calendar.component(.weekday, from: days.first?.date ?? Date())
        
        for _ in 0..<firstWeekDay - 1 {
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        return days
    }
}

