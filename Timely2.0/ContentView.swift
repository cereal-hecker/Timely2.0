//
//  ContentView.swift
//  Timely2.0
//
//  Created by Riya Batla on 27/01/24.
//

import SwiftUI
import Firebase
import FirebaseAuth
struct ContentView: View {

    var body: some View {
        if Auth.auth().currentUser != nil {
            RootView()
        } else {
            GetStartedView()
        }
    }
}

#Preview {
    ContentView()
}
