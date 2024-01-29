//
//  Schedule.swift
//  Timely2.0
//
//  Created by Riya Batla on 28/01/24.
//

import SwiftUI


struct Schedule: View {
    var body: some View {
        VStack(alignment: .leading){
//            Text("23 SEPTEMBER")
//                .foregroundColor(.grey7)
//                .font(.caption)
//                .bold()
//                .padding(.horizontal)
//            Text("Today")
//                .foregroundColor(.white)
//                .font(.title)
//                .bold()
//                .padding(.horizontal)
            HorizontalCalendar()
            ZStack(alignment: .top){
                UnevenRoundedRectangle(cornerRadii: .init(
                    topLeading: 50,
                    topTrailing: 50),
                    style: .continuous)
                    .foregroundColor(.grey1)
                VStack{
                    TagBar()
                        .padding(.top, 25)
                        .padding(.bottom, 10)
                    EventList()
                }
            }
        }
        .background(.black)
    }
}

#Preview {
    Schedule()
}
