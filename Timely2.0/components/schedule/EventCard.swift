//
//  EventCard.swift
//  Timely2.0
//
//  Created by Riya Batla on 28/01/24.
//

import SwiftUI

struct EventCard: View {
    var event: Event

    var body: some View {
        HStack(alignment: .top) {
            Circle()
                .fill(Color.white)
                .frame(width: 20, height: 20)
                .offset(y: 15)
            HStack {
                VStack(alignment: .leading) {
                    Text(event.time)
                        .font(.callout)
                        .bold()
                    Text(event.title)
                        .font(.callout)
                    Text(event.location)
                        .font(.footnote)
                    Text(event.mode)
                        .font(.footnote)
                    HStack {
                        ForEach(event.tags, id: \.text) { tag in
                            HStack{
                                Text(tag.text)
                                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                    Image(systemName: "multiply")
                                })
                            }
                                .font(.footnote)
                                .padding(5)
                                .background(tag.color)
                                .cornerRadius(5)
                        }
                    }
                    .foregroundColor(.black)
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
    EventCard(event: Event(time: "08:00 AM",
                           title: "iOS Bootcamp",
                           location: "Tech Park, SRM University",
                           mode: "Offline",
                           tags: [("Important", Color.primarypink), ("College", Color.tagpurple)]))

}
