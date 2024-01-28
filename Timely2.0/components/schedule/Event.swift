//
//  Event.swift
//  Timely2.0
//
//  Created by Riya Batla on 28/01/24.
//

import SwiftUI

struct Event: Identifiable {
    var id = UUID()
    var time: String
    var title: String
    var location: String
    var mode: String
    var tags: [(text: String, color: Color)]
}
