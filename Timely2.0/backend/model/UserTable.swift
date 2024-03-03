//
//  UserTable.swift
//  Timely
//
//  Created by user2 on 27/02/24.
//

import Foundation
enum Mode{
    case Online
    case Offline
}

struct UserTask: Identifiable, Codable {
    let id: String
    let venue: String
    let dateTime: TimeInterval
    let category: String
    var isCompleted: Bool
    
    mutating func setDone(_ state: Bool) {
        isCompleted = state
    }
}
