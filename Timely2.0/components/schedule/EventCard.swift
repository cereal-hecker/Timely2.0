//
//  EventCard.swift
//  Timely2.0
//
//  Created by Riya Batla on 28/01/24.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct EventCard: View {
    
    let event : UserTask
    
    var body: some View {
        HStack(alignment: .top) {
            Circle()
                .fill(Color.white)
                .frame(width: 20, height: 20)
                .offset(y: 15)
            HStack {
                VStack(alignment: .leading) {
                    Text(event.dateTime.formatted())
                        .font(.callout)
                        .bold()
                    Text(event.venue)
                        .font(.callout)
                    Text("\(event.location.latitude)")
                        .font(.footnote)
                    Text("\(event.location.longitude)")
                        .font(.footnote)
                    Text(event.mode)
                        .font(.footnote)
                    HStack{
                        ForEach(event.tags, id: \.self) { tag in
                            HStack {
                                Text(tag)
                                Button(action: {
                                    // Replace this with the intended action
                                }) {
                                    Image(systemName: "multiply")
                                }
                            }
                            .font(.footnote)
                            .padding(5)
                            .background(Color.blue) // Assuming tagColor is the color associated with the tag
                            .cornerRadius(5)
                        }
                    }

                }
                .padding()
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .foregroundColor(.white)
            .background(Color.grey2)
            .cornerRadius(12)
        }
        .padding()
    }
}

#Preview {
    EventCard(event: .init(
        id: "123",
        venue: "IOS Bootcamp",
        dateTime: Date().timeIntervalSince1970,
        location: GeoPoint(latitude: 12.82318919, longitude: 80.04440627),
        repeatTask: "once",
        mode: "Offline",
        tags: ["important"],
        isCompleted: false
    ))

}

