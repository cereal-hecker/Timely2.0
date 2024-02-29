//
//  RootView.swift
//  Timely2.0
//
//  Created by user2 on 29/02/24.
//

import SwiftUI

struct RootView: View {
    
    @State private var showSignInView: Bool = false
    @StateObject var authManager = AuthenticationManager()

    var body: some View {
        ZStack{
            NavigationStack{
                GetStartedView(showSiginInView: $showSignInView)
            }
            
        }
    }
}

#Preview {
    RootView()
}
