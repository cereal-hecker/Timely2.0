//
//  EventCard.swift
//  Timely2.0
//
//  Created by Riya Batla on 28/01/24.
//

import SwiftUI

struct EventCard: View {
    var time: String
    var title: String
    var location: String
    var mode: String
    var tags: [(text: String, color: Color)]

    var body: some View {
        HStack(alignment: .top){
            Circle()
                .fill(.white)
                .frame(width: 20, height: 20)
                .offset(y: 15)
            HStack {
                VStack(alignment: .leading) {
                    Text(time)
                        .font(.callout)
                        .bold()
                    
                    Text(title)
                        .font(.callout)
                    
                    Text(location)
                        .font(.footnote)
                    
                    Text(mode)
                        .font(.footnote)
                    
                    HStack {
                        ForEach(tags, id: \.text) { tag in
                            Text(tag.text)
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
    EventCard(time: "08:00 AM",
              title: "iOS Bootcamp",
              location: "Tech Park, SRM University",
              mode: "Offline",
              tags: [("Important", Color.primarypink), ("College", Color.tagpurple)])

}
