//
//  WeekView.swift
//  Timely2.0
//
//  Created by user2 on 22/03/24.
//

import SwiftUI

struct WeekView: View {
    @EnvironmentObject var weekStore: WeekStore
    var week: Week
    var body: some View {
        VStack {
            HStack {
                ForEach(0..<7) { i in
                    ZStack {
                        Rectangle()
                            .frame(width: 48, height: 60)
                            .foregroundColor(week.dates[i] == week.referenceDate ? .grey2 : .clear)
                            .cornerRadius(8)
                        VStack {
                            Text(week.dates[i].weekDayAbbrev())
                                .frame(maxWidth: .infinity)
                                .font(.caption)
                                .foregroundStyle(Color.white)
                            Text(week.dates[i].formatted(.dateTime .day()))
                                .font(.system(size: 18))
                                .bold()
                                .foregroundColor(.white)
                        }
                    }
                    .onTapGesture {
                        withAnimation {
                            weekStore.selectedDate = week.dates[i]
                            print(week.dates[i])
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .padding(.horizontal)
        }
    }
}


#Preview{
    WeekView(week: .init(index: 1, dates:
                            [
                                Date().yesterday.yesterday.yesterday,
                                Date().yesterday.yesterday,
                                Date().yesterday,
                                Date(),
                                Date().tomorrow,
                                Date().tomorrow.tomorrow,
                                Date().tomorrow.tomorrow.tomorrow
                            ],
                         referenceDate: Date()))
    .environmentObject(WeekStore())
}
