//
//  User.swift
//  Timely2.0
//
//  Created by user2 on 06/02/24.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let username: String
    let email: String
    
    
    var initials : String{
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: username){
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        return ""
    }
}

extension User {
    static var mocuser = User(id:NSUUID().uuidString, username: "rex", email: "Rex@gmail.com")
}

