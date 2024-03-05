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
        self._event = FirestoreQuery(collectionPath: "user/\(userId)/tasks")
    }
    var currentDate = Date().timeIntervalSince1970
    var body: some View {
        
        ScrollView {
            ZStack(alignment: .topLeading){
                Rectangle()
                    .frame(width: 2)
                    .overlay(Color.white)
                    .offset(x: 25, y: 32)
                VStack(spacing: 0) {
                    ForEach(event.filter{$0.dateTime >= currentDate}.sorted(by: { $0.dateTime < $1.dateTime }))
                    { event in
                        EventCard(event: event)
                    }

                    ForEach(event.filter{$0.dateTime < currentDate}.sorted(by: { $0.dateTime < $1.dateTime })) { event in
                        EventCard(event: event)
                    }
                    
                }
        
            }
        }
//        .background(.black)
    }
}


#Preview {
    EventList(userId: "UOg585ZxeHa7HCs8LnWjoKQWnyt1")
}
