//
//  User.swift
//  Timely2.0
//
//  Created by user2 on 06/02/24.
//

import Foundation
import Firebase

struct User: Identifiable, Codable {
    let id: String
    let username: String
    let email: String
    let dateJoined: TimeInterval
    
    var initials : String{
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: username){
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        return ""
    }
}
