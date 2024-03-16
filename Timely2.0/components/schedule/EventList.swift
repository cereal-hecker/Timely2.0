//
//  EventList.swift
//  Timely2.0
//
//  Created by Riya Batla on 28/01/24.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct EventList: View {
    
    var userId: String
    @FirestoreQuery var event: [UserTask]
    
    init(userId: String) {
        self.userId = userId
        self._event = FirestoreQuery(collectionPath: "customer/\(userId)/tasks")
    }
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                ZStack(alignment: .topLeading){
                    Rectangle()
                        .frame(width: 2)
                        .overlay(Color.white)
                        .offset(x: 25, y: 32)
                    LazyVStack(spacing: 0) {
                        ForEach(event.sorted(by: { $0.dateTime < $1.dateTime })) { event in
                            EventCard(event: event)
                                .id(event.dateTime)
                        }
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    // Scroll to the upcoming event after a delay
                    if let upcomingEventTimestamp = findUpcomingEventTimestamp() {
                        withAnimation {
                            proxy.scrollTo(upcomingEventTimestamp, anchor: .top)
                        }
                    }
                }
            }
        }
    }
    
    private func findUpcomingEventTimestamp() -> TimeInterval? {
        let currentDate = Date().timeIntervalSince1970
        let upcomingEvents = event.filter { $0.dateTime > currentDate }
        return upcomingEvents.min(by: { $0.dateTime < $1.dateTime })?.dateTime
    }
}



#Preview {
    EventList(userId: "9JXe54FCMtSx5xwKiic2mTfFctk1")
}
