//
//  HorizontalCalendar.swift
//  Timely2.0
//
//  Created by Riya Batla on 28/01/24.
//

import SwiftUI

struct HorizontalCalendar: View {
    @ObservedObject var dayPlanner = DayPlanner()
    var body: some View {
            VStack(alignment: .leading) {
                    Text(dayPlanner.currentDate.monthYYYY())
                    .textCase(.uppercase)
                        .foregroundColor(.grey7)
                        .font(.caption)
                        .bold()
                    Text(dayPlanner.currentDate.formatted(.dateTime .weekday(.wide)))
                        .foregroundColor(.white)
                        .font(.title)
                        .bold()
                    HorizontalScrollView()
            }
                .padding(.horizontal)
    }
}

#Preview {
    HorizontalCalendar()
}



struct HorizontalScrollView: View {

    @ObservedObject var dayPlanner = DayPlanner()
    var body: some View {
            ScrollViewReader { proxy in
                let datesArray = dayPlanner.dates()
                ScrollView(.horizontal,showsIndicators:false){
                    HStack{

                        ForEach(datesArray.indices, id:\.self) { i in
                            let d = datesArray[i]
                            ZStack {
                                if dayPlanner.isCurrent(_date: d){
                                    Rectangle()
                                        .foregroundStyle(Color.grey1)
                                        .frame(height: 70)
                                        .cornerRadius(12)
                                }

                                VStack {
                                    Text(d.weekDayAbbrev())
                                    Text(d.dayNum())
                                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                        .font(.system(size: 24))
                                }
//                                .frame(width: 55)
                                .padding()
                                .foregroundStyle(Color.white)
                            }
                        }
                    }
                }
                .onAppear{
                    if let pos = datesArray.firstIndex(of: dayPlanner.currentDate){
                        proxy.scrollTo(pos,anchor: .center)
                    }
                }
                Button("Jump to current"){
                    if let pos = datesArray.firstIndex(of: dayPlanner.currentDate){
                        proxy.scrollTo(pos,anchor: .center)
                    }

                }
            }
    }
}
