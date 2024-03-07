//
//  UserTable.swift
//  Timely
//
//  Created by user2 on 27/02/24.
//

import Foundation
import Firebase

enum Mode{
    case Online
    case Offline
}

struct UserTask: Identifiable, Codable {
    let id: String
    let venue: String
    let dateTime: TimeInterval
    let location: GeoPoint
    let repeatTask: String
    let earlyTime: String
    let tags: [String]
    
    
    var isCompleted: Bool
    
    mutating func setDone(_ state: Bool) {
        isCompleted = state
    }
}


struct Leaderboard: Identifiable, Codable {
    let id: String
    let currentHp: Int
    let level: Int
}
