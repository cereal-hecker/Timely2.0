//
//  UpcomingEventCard.swift
//  Timely2.0
//
//  Created by Riya Batla on 28/01/24.
//

import SwiftUI

struct UpcomingEventCard: View {
    
    var body: some View {
        HStack(){
            VStack(alignment: .leading){
                Text("10 minutes to")
                    .font(.caption)
                HStack(alignment: .lastTextBaseline){
                    Text("08:00")
                        .font(.title2)
                        .bold()
                }
            }
            Spacer()
            VStack(alignment: .trailing){
                Text("iOS Bootcamp")
                    .font(.title2)
                    .bold()
                Text("Tech Park, SRM University")
                    .font(.caption)
                    .italic()
            }
        }
        .padding(5)
        .padding()
        .background(.grey2)
        .cornerRadius(10)
        .foregroundColor(.white)
    }
}

#Preview {
    UpcomingEventCard()
}
