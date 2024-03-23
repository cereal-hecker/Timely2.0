//
//  WeekModel.swift
//  Timely2.0
//
//  Created by user2 on 22/03/24.
//

import Foundation
import Combine

class WeekStore: ObservableObject {
    @Published var currentTag:String = "all"
    @Published var offlineTags: [String] = ["All"]
    @Published var weeks: [Week] = []
    var oldDate: Date = Date()
    @Published var selectedDate: Date {
        didSet {
            calcWeeks(with: selectedDate)
            clearOfflineTags(newDate: selectedDate)
            currentTag = "all"
        }
    }
    init(with date: Date = Date()) {
        self.selectedDate = Calendar.current.startOfDay(for: date)
        calcWeeks(with: selectedDate)
    }
    
    
    // MARK: Calculate Weeks for next updating
    private func calcWeeks(with date: Date) {
        weeks = [
            week(for: Calendar.current.date(byAdding: .day, value: -7, to: date)!, with: -1),
            week(for: date, with: 0),
            week(for: Calendar.current.date(byAdding: .day, value: 7, to: date)!, with: 1)
        ]
    }
    
    
    // MARK: Fetching Week
    private func week(for date: Date, with index: Int) -> Week {
        var result: [Date] = .init()
        
        guard let startOfWeek = Calendar.current.date(from: Calendar.current.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date)) else { return .init(index: index, dates: [], referenceDate: date) }
        
        (0...6).forEach { day in
            if let weekday = Calendar.current.date(byAdding: .day, value: day, to: startOfWeek) {
                result.append(weekday)
            }
        }
        
        return .init(index: index, dates: result, referenceDate: date)
    }
    
    
    // MARK: Today's Date
    func selectToday() {
        select(date: Date())
    }
    
    // MARK: Selected Date by USER
    func select(date: Date) {
        selectedDate = Calendar.current.startOfDay(for: date)
        
    }
    
    
    // MARK: Changing the value to get next array of Week
    func update(to direction: TimeDirection) {
        switch direction {
        case .future:
            selectedDate = Calendar.current.date(byAdding: .day, value: 7, to: selectedDate)!
            
        case .past:
            selectedDate = Calendar.current.date(byAdding: .day, value: -7, to: selectedDate)!
            
        case .unknown:
            selectedDate = selectedDate
        }
        
        calcWeeks(with: selectedDate)
    }
    
    func clearOfflineTags(newDate: Date) {
        if(oldDate != newDate) {
            oldDate = newDate
            offlineTags.removeAll()
            offlineTags.append("All")
        }
    }
}



struct Week {
    let index: Int
    let dates: [Date]
    var referenceDate: Date
}

enum TimeDirection {
    case future
    case past
    case unknown
}
