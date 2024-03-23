//
//  DateExtensions.swift
//  Timely2.0
//
//  Created by user2 on 22/03/24.
//

import Foundation

extension Date {
    
    func monthYYYY() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
    
    func weekDayAbbrev() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E"
        return dateFormatter.string(from: self)
    }
    
    func toString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.calendar = Calendar.current
        formatter.dateFormat = format
        
        return formatter.string(from: self)
    }
    
    var yesterday: Date {
        Calendar.current.date(byAdding: .day, value: -1, to: self)!
    }
    
    var tomorrow: Date {
        Calendar.current.date(byAdding: .day, value: 1, to: self)!
    }
    
    private func isEqual(to date: Date, toGranularity component: Calendar.Component, in calendar: Calendar = .current) -> Bool {
        var customCalendar = Calendar(identifier: .gregorian)
        customCalendar.firstWeekday = 2
        
        return customCalendar.isDate(self, equalTo: date, toGranularity: component)
    }
    
    func isInSameWeek(as date: Date) -> Bool {
        isEqual(to: date, toGranularity: .weekOfYear)
    }
    
    func isInSameDay(as date: Date) -> Bool {
        isEqual(to: date, toGranularity: .day)
    }
}
