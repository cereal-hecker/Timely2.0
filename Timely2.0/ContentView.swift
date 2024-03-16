//
//  ContentView.swift
//  Timely2.0
//
//  Created by Riya Batla on 27/01/24.
//

import SwiftUI
import Firebase
import Combine
import FirebaseAuth


class ContentViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupUser()
    }
    
    private func setupUser(){
        AuthenticationManager.shared.$userSession.sink { [weak self] userSession in
            self?.userSession = userSession
        }.store(in: &cancellables)
    }
}

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    var body: some View {
        Group{
            if viewModel.userSession != nil {
                RootView()
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    ContentView()
}
