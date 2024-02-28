//
//  tabletry1.swift
//  timelyNew
//
//  Created by user2 on 29/01/24.
//

import SwiftUI


struct HistoryView: View {
    @State private var historyItems: [HistoryItem] = [
        HistoryItem(type: true, points: 10, time: "09:00 AM", event: "iOS Bootcamp", date: "Jan 29, 2024", status: "Reached on time"),
        HistoryItem(type: true, points: 10, time: "09:00 AM", event: "iOS Bootcamp", date: "Jan 29, 2024", status: "Reached on time"),
        HistoryItem(type: true, points: 10, time: "09:00 AM", event: "iOS Bootcamp", date: "Jan 29, 2024", status: "Reached on time"),
        HistoryItem(type: true, points: 10, time: "09:00 AM", event: "iOS Bootcamp", date: "Jan 29, 2024", status: "Reached on time"),
        HistoryItem(type: false, points: 11, time: "012:00 AM", event: "iOS Bootcamp", date: "Jan 29, 2024", status: "Reached on time"),
        HistoryItem(type: true, points: 15, time: "012:00 AM", event: "iOS Bootcamp", date: "Jan 29, 2024", status: "Reached on time"),
        HistoryItem(type: false, points: 8, time: "02:30 PM", event: "Project Meeting", date: "Jan 29, 2024", status: "Discussed project milestones"),
        HistoryItem(type: true, points: 12, time: "05:15 PM", event: "Coding Session", date: "Jan 29, 2024", status: "Implemented new feature"),
        HistoryItem(type: true, points: 15, time: "08:45 AM", event: "Code Review", date: "Jan 29, 2024", status: "Reviewed and improved code quality"),
        HistoryItem(type: false, points: 10, time: "03:00 PM", event: "Team Training", date: "Jan 29, 2024", status: "Learned about new development tools")
    ]

    var body: some View {
        VStack(alignment: .leading){
            Text("History")
                .font(.largeTitle .bold())
                .foregroundStyle(Color.white)
                .padding()
            List(historyItems) { item in
                HistoryRow(item: item)
                    .listRowBackground(Color.grey2)
                    .listRowSeparatorTint(.blue, edges: .bottom)
            }
            .offset(y: -20)
            
            
            .scrollContentBackground(.hidden)
            
//            .foregroundColor(.white)
//            .scrollContentBackground(.hidden)
//            .navigationTitle("History")
//            .listRowSeparator(.hidden)
//            .listRowBackground(Color.clear)
        }
        .background(Color.black)
            
    }
}

struct HistoryRow: View {
    var item: HistoryItem
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                HStack(spacing: 4) {
                    if item.type {
                        Image(systemName: "plus")
                            .foregroundColor(.green)
                    } else {
                        Image(systemName: "minus")
                            .foregroundColor(.red)
                    }
                    
                    Text("\(item.points)")
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundStyle(Color.white)
                    Image(systemName: "star.fill")
                        .foregroundColor(Color.orange)
                        .padding(.trailing, 10)
                }
                .frame(width: 100)
                
                VStack(alignment: .leading){
                    Text(item.time)
                        .font(.headline)
                        .foregroundStyle(Color.white)
                        .multilineTextAlignment(.leading)
                    Text(item.event)
                        .font(.title2)
                        .foregroundStyle(Color.white)
                        .multilineTextAlignment(.leading)
                    Text("\(item.date), \(item.status)")
                        .font(.caption)
                        .foregroundStyle(Color.white)
                        .multilineTextAlignment(.leading)
//                    if item.type {
//                        Text("Earned \(item.points) points")
//                            .font(.footnote)
//                            .foregroundColor(.green)
//                            .multilineTextAlignment(.leading)
//                    } else {
//                        Text("Attended")
//                            .font(.footnote)
//                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
//                            .multilineTextAlignment(.leading)
//                    }
                }
            }
//            HStack{
//                Image(systemName: "plus")
//                    .foregroundColor(.green)
//                Text("hi")
//                    .font(.title)
//                    .fontWeight(.heavy)
//                    .foregroundStyle(Color.white)
//                Image(systemName: "star.fill")
//                    .foregroundColor(Color.orange)
//
//                Spacer()
//                VStack(alignment: .leading){
//                    Text("09:00 AM, IOS Bootcamp")
//                        .font(.title3)
//                    Text("09:00 AM, IOS Bootcamp")
//                        .font(.subheadline)
//                }
//                .foregroundColor(.white)
//
//            }
//            .padding(.horizontal, 10)
//            .padding(.vertical, 4)
                
        }
        .padding(.horizontal,0)
    }
        
}

#Preview {
    HistoryView()
}


