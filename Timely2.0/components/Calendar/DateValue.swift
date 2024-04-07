//
//  SwiftUIView.swift
//  Timely2.0
//
//  Created by user2 on 07/04/24.
//

import SwiftUI

struct DateValue: Identifiable {
    var id = UUID().uuidString
    var day : Int
    var date: Date
}

extension Date{
    func getAllDates() -> [Date] {
        let calendar = Calendar.current
        
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year,.month], from: self))!
        
        let range = calendar.range(of: .day, in: .month, for: self)
        
        return range!.compactMap { day -> Date in
            return calendar.date(byAdding: .day, value: day - 1 , to: startDate)!
        }
    }
}
