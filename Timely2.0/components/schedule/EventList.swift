//
//  EventList.swift
//  Timely2.0
//
//  Created by Riya Batla on 28/01/24.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import Combine


struct EventList: View {
    @EnvironmentObject var weekStore : WeekStore
    var userId: String
    @FirestoreQuery var events: [UserTask]
    
    init(userId: String) {
        self.userId = userId
        self._events = FirestoreQuery(collectionPath: "customer/\(userId)/tasks")
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 15) {
                ForEach(weekStore.offlineTags, id: \.self) { tag in
                    Button(tag) {
                        weekStore.currentTag = tag.lowercased()
                    }
                    .buttonStyle(
                        RoundedButtonStyle(
                            backgroundColor: .grey1,
                            pressedBackgroundColor: .white,
                            borderColor: .white,
                            foregroundColor: .grey7,
                            pressedForegroundColor: .black,
                            cornerRadius: 8))
                }
            }
            .padding(.top,25)
            .padding(.bottom,5)
            
            ScrollViewReader { proxy in
                ScrollView {
                    ZStack(alignment: .topLeading){
                        Rectangle()
                            .frame(width: 2)
                            .overlay(Color.white)
                            .offset(x: 25, y: 32)
                        LazyVStack(spacing: 0) {
                            ForEach(events
                                .filter { event in
                                    let itemDate = Date(timeIntervalSince1970: event.dateTime)
                                    let itemStartDate = Calendar.current.startOfDay(for: itemDate)
                                    let selectedDate = Calendar.current.startOfDay(for: weekStore.selectedDate)
                                    if weekStore.currentTag == "all" {
                                        return itemStartDate == selectedDate
                                    } else {
                                        let lowercasedTags = event.tags.map { $0.lowercased() }
                                        return itemStartDate == selectedDate && lowercasedTags.contains(weekStore.currentTag)
                                    }
                                }
                                .sorted(by: { $0.dateTime < $1.dateTime })
                            ) { event in
                                EventCard(event: event)
                                    .id(event.dateTime)
                            }
                        }
                    }
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        if let upcomingEventTimestamp = findUpcomingEventTimestamp() {
                            withAnimation {
                                proxy.scrollTo(upcomingEventTimestamp, anchor: .top)
                            }
                        }
                    }
                }
            }
        }
    }
    
    // MARK: Searching For the Next Event from Current Time
    private func findUpcomingEventTimestamp() -> TimeInterval? {
        let currentDate = Date().timeIntervalSince1970
        let upcomingEvents = events.filter { $0.dateTime > currentDate }
        return upcomingEvents.min(by: { $0.dateTime < $1.dateTime })?.dateTime
    }
}



#Preview {
    EventList(userId: "9JXe54FCMtSx5xwKiic2mTfFctk1")
}
