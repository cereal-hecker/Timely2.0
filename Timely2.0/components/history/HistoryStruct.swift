//
//  History.swift
//  timelyNew
//
//  Created by user2 on 29/01/24.
//

import Foundation

struct HistoryItem: Identifiable {
    var id: UUID = UUID()
    var type: Bool
    var points: Int
    var time: String
    var event: String
    var date: String
    var status: String

    init(type: Bool, points: Int, time: String, event: String, date: String, status: String) {
        self.type = type
        self.points = points
        self.time = time
        self.event = event
        self.date = date
        self.status = status
    }
}

