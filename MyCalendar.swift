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
    private var calender = Calendar(identifier: .iso8601)
    private let dateFormatter = DateFormatter()
    init() {
        calender.timeZone = TimeZone(identifier: "UTC")!
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
        let currentYear = calender.component(.year, from: currentDate)
        let startOfYear = calender.date(from: DateComponents(year:currentYear, month: 1, day:1))
        let range = calender.range(of: .day, in: .year, for: startOfYear!)!
        let datesArrInYear = range.compactMap{
            calender.date(byAdding: .day,value: $0 - 1, to: startOfYear!)
        }
//        let range = calender.range(of: .day, in: .year, for: currentDate)!
//        let datesArrInYear = range.compactMap{
//            calender.date(byAdding: .day,value: $0 - 1, to: currentDate)
//        }
        return datesArrInYear
    }
}

extension Date {
    func monthYYYY() -> String {
        return self.formatted(.dateTime .month(.wide) .year())
    }
    
    func weekDayAbbrev() -> String {
        return self.formatted(.dateTime .weekday(.abbreviated))
    }
    
    func dayNum() -> String {
        return self.formatted(.dateTime .day())
    }
}
