//
//  MyCalendar.swift
//  Timely2.0
//
//  Created by N Manishramar on 28/01/24.
//

import Foundation

struct MyCalendar{
    private(set) var today = Date()
    private(set) var currentDate = Date()
    private var calendar = Calendar(identifier: .iso8601)
    private let dateFormatter = DateFormatter()
    init() {
        calendar.timeZone = TimeZone(identifier: "UTC")!
        dateFormatter.timeZone = TimeZone(identifier: "UTC")!
        dateFormatter.dateFormat = "yyyyMMdd"
        
        let todayStr = dateFormatter.string(from: today)
        currentDate = dateFormatter.date(from: todayStr)!
    }
    
    mutating func setCurrentDate(to dateStr: String){
        let d = dateFormatter.date(from: dateStr)
        if let d {
            currentDate = d
        }
    }
    
    func datesInYear() -> [Date] {
        let currentYear = calendar.component(.year, from: currentDate)
        let startOfYear = calendar.date(from: DateComponents(year:currentYear, month: 1, day:1))
        let range = calendar.range(of: .day, in: .year, for: startOfYear!)!
//        let datesArrInYear = range.compactMap{
//            calendar.date(byAdding: .day,value: $0 - 1, to: startOfYear!)
//        }
//       let range = calendar.range(of: .day, in: .year, for: currentDate)!
        let datesArrInYear = range.compactMap{
            calendar.date(byAdding: .day,value: $0 - 1, to: startOfYear!)
        }
        return datesArrInYear
    }
    
    func datesInAWeek(from date: Date) -> [Date] {
        let range = calendar.range(of: .weekday, in: .weekOfYear, for: date)!
        let datesArrInWeek = range.compactMap {
            calendar.date(byAdding: .day,value: $0 - 1, to: date)
        }
        return datesArrInWeek
    }
    
}




extension Date {
    func monthYYYY() -> String {
        return self.formatted(.dateTime .day() .month(.wide))
    }
    
    func weekDayAbbrev() -> String {
        return self.formatted(.dateTime .weekday(.abbreviated))
    }
    
    func dayNum() -> String {
        return self.formatted(.dateTime .day())
    }
}
