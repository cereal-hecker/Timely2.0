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
  //      let week = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
        VStack {
            HStack {
                Text(dayPlanner.currentDate.monthYYYY())
                    .font(.title)
                    .foregroundStyle(Color.white.opacity(0.6))
                    Spacer()
            }
            HStack {
                Text(dayPlanner.currentDate.formatted(.dateTime .weekday(.wide)))
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.white.opacity(0.6))
                    Spacer()
            }
            DateScrollView()
        }.background(Color.black)
    }
}












#Preview {
    HorizontalCalendar()
}




struct DateScrollView: View {
    @ObservedObject var dayPlanner = DayPlanner()
    var body: some View {
        GeometryReader{ geo in
            ScrollViewReader { proxy in
                let datesArray = dayPlanner.dates()
                ScrollView(.horizontal,showsIndicators:false){
                    HStack{
                        
                        ForEach(datesArray.indices, id:\.self) { i in
                            let d = datesArray[i]
                            ZStack {
                                if dayPlanner.isCurrent(_date: d){
                                    Rectangle()
                                        .foregroundStyle(Color.pink)
                                        .frame(height: 60)
                                        .cornerRadius(12)
                                }
                                
                                VStack {
                                    Text(d.weekDayAbbrev())
                                    Text(d.dayNum())
                                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                }
                                .frame(width: geo.size.width / 8)
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
}
