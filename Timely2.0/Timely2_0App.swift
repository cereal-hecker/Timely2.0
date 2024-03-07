//
//  Timely2_0App.swift
//  Timely2.0
//
//  Created by Riya Batla on 27/01/24.
//

import SwiftUI
import Firebase

@main
struct TimelyApp: App {
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
            //LocationVerificationView()
            
        }
    }
}
