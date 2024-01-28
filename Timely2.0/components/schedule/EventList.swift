//
//  EventList.swift
//  Timely2.0
//
//  Created by Riya Batla on 28/01/24.
//

import SwiftUI

struct EventList: View {
    var events: [Event] = [
        Event(time: "08:00 AM",
              title: "iOS Bootcamp",
              location: "Tech Park, SRM University",
              mode: "Offline",
              tags: [("Important", Color.primarypink), ("College", Color.tagpurple)]),
        Event(time: "08:00 AM",
              title: "iOS Bootcamp",
              location: "Tech Park, SRM University",
              mode: "Offline",
              tags: [("Important", Color.primarypink), ("College", Color.tagpurple)]),
        Event(time: "08:00 AM",
              title: "iOS Bootcamp",
              location: "Tech Park, SRM University",
              mode: "Offline",
              tags: [("Important", Color.primarypink), ("College", Color.tagpurple)]),
        Event(time: "08:00 AM",
              title: "iOS Bootcamp",
              location: "Tech Park, SRM University",
              mode: "Offline",
              tags: [("Important", Color.primarypink), ("College", Color.tagpurple)]),
        Event(time: "08:00 AM",
              title: "iOS Bootcamp",
              location: "Tech Park, SRM University",
              mode: "Offline",
              tags: [("Important", Color.primarypink), ("College", Color.tagpurple)]),
        Event(time: "08:00 AM",
              title: "iOS Bootcamp",
              location: "Tech Park, SRM University",
              mode: "Offline",
              tags: [("Important", Color.primarypink), ("College", Color.tagpurple)]),
    ]

    var body: some View {
        ScrollView {
            ZStack(alignment: .topLeading){
                Rectangle()
                    .frame(width: 2)
                    .overlay(Color.white)
                    .offset(x: 25, y: 32)
                VStack(spacing: 0) {
                    ForEach(events) { event in
                        EventCard(event: event)
                    }
                }
            }
        }
//        .background(.black)
    }
}


#Preview {
    EventList()
}
