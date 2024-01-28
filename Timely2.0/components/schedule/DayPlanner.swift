//
//  DayPlanner.swift
//  Timely2.0
//
//  Created by N Manishramar on 28/01/24.
//

import Foundation


class DayPlanner: ObservableObject{
    @Published private var model = MyCalendar()
    
    
    var currentDate: Date {
        return model.currentDate
    }
    
    func setCurrentDate(to dateStr: String) {
        model.setCurrentDate(to: dateStr)
    }
    
    func dates() ->[Date]{
        model.datesInYear()
    }
    
    
    func isCurrent( _date : Date) -> Bool {
        return _date == currentDate
    }
    
    func datesInAWeek(from date: Date) -> [Date] {
        model.datesInAWeek(from: date)
    }
}
