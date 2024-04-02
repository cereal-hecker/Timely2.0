//
//  LandingView.swift
//  Timely2.0
//
//  Created by Riya Batla on 29/01/24.
//

import SwiftUI
import FirebaseFirestoreSwift
import Firebase
import FirebaseAuth
import Combine
import CoreLocation
import _CoreLocationUI_SwiftUI


@MainActor
class LandingViewManager: ObservableObject {
    @Published var contentChanged: Bool = false
    @Published var levelDocId: String = ""
    @Published var currentUser: User?
    private var cancellables = Set<AnyCancellable>()
    init() {
        setupUser()
    }
    
    func setupUser(){
        UserManager.shared.$currentUser.sink { [weak self] user in
            self?.currentUser = user
            print("DEBUG: User in viewModel from Profile is \(String(describing: user))")
        }.store(in: &cancellables)
    }
}

struct LandingView: View {
    @State var userId: String
    @StateObject var viewModel = LandingViewManager()
    @FirestoreQuery var items: [UserTask]
    @State private var isLongPressed: Bool = false
    
    
    init(userId: String) {
        self.userId = userId
        self._items = FirestoreQuery(collectionPath: "customer/\(userId)/tasks")
    }
    
    private var currentUser: User? {
        return viewModel.currentUser
    }
    var body: some View {
        NavigationView {
            ScrollView {
                ZStack(alignment:.top){
                    
                    ModelView(currentHp: Double(currentUser?.currentHp ?? 0))
                        .offset(y:-50)
                        .padding(.top,0)
                        .frame(height: 700)
                    VStack {
                        HStack{
                            Text("Level ").font(.title2).bold().foregroundStyle(.white) + Text(String(currentUser?.level ?? 0))
                                .font(.title2)
                                .foregroundColor(.white)
                                .bold()
                        }
                        .offset(y: -480)
                        
                        VStack {
                            HealthCard(currentHp: Double(currentUser?.currentHp ?? 0))
                                .padding(.bottom)
                            
                            if items.filter({ $0.dateTime > Date().timeIntervalSince1970 && !$0.isCompleted }).isEmpty {
                                
                                HStack(spacing:30) {
                                    Text("No Upcoming Tasks ...")
                                }
                                .padding(5)
                                .padding()
                                .background(.grey2)
                                .cornerRadius(10)
                                .foregroundColor(.white)
                            } else {
                                ForEach(items.filter { $0.dateTime > Date().timeIntervalSince1970 && !$0.isCompleted }.sorted(by: { $0.dateTime < $1.dateTime })){ task in
                                    SwipeAction(cornerRadius: 10, direction: .trailing){
                                        UpcomingEventCard(task: task)
                                    } actions: {
                                        Action{
                                            withAnimation(.easeInOut){
                                                
                                                // MARK: deleting the task
                                                UserManager.shared.deleteTask(task: task)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .offset(y: -20)
                    .padding(.top,500)
                }
                .padding()
                .navigationBarHidden(true)
                .background(Color.clear)
                .overlay(
                    AddMission()
                        .position(CGPoint(x: 350.0, y: 490.0))
                )
            }
            .scrollIndicators(.hidden)
            .background(.black)
        }
        .onChange(of: viewModel.contentChanged) {
            
        }
    }
}
#Preview{
    LandingView(userId:"9JXe54FCMtSx5xwKiic2mTfFctk1")
}



extension LandingView {
    
    // custom swipe
    struct SwipeAction<Content: View>: View {
        var cornerRadius: CGFloat = 0
        var direction : SwipeDirection = .trailing
        @ViewBuilder var content: Content
        @ActionBuilder var actions : [Action]
        
        let viewId = UUID()
        @State var isEnable: Bool = true
        var body: some View {
            ScrollViewReader { scrollProxy in
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 0){
                        content
                            .containerRelativeFrame(.horizontal)
                            .id(viewId)
                        ActionButtons{
                            withAnimation(.snappy){
                                scrollProxy.scrollTo(viewId, anchor: direction == .trailing ? .topLeading : .topTrailing)
                            }
                        }
                    }
                    .frame(height: 100)
                    .scrollTargetLayout()
                    .visualEffect { content, geometryProxy in
                        content
                            .offset(x: scrolloffset(geometryProxy))
                    }
                }
                .scrollIndicators(.hidden)
                .scrollTargetBehavior(.viewAligned)
                .clipShape(.rect(cornerRadius: cornerRadius))
            }
            .allowsHitTesting(isEnable)
        }
        
        
        @ViewBuilder
        func ActionButtons (resetPosition: @escaping () -> () ) -> some View {
            Rectangle()
                .fill(.red)
                .frame(width: CGFloat(actions.count) * 100)
                .overlay(alignment: direction.alignment) {
                    HStack(spacing:0){
                        ForEach (actions) { button in
                            Button(action: {
                                Task {
                                    isEnable = false
                                    resetPosition()
                                    try await Task.sleep(for: .seconds(0.25))
                                    button.action()
                                    try await Task.sleep(for: .seconds(0.1))
                                    isEnable = true
                                }
                            }, label: {
                                Image(systemName: "trash.fill")
                                    .font(.title)
                                    .frame(width: 100)
                                    .foregroundStyle(.white)
                                    .contentShape(.rect)
                            })
                            .buttonStyle(.plain)
                            .background(.red)
                        }
                    }
                }
        }
        
        func scrolloffset(_ proxy: GeometryProxy) -> CGFloat {
            let minX = proxy.frame(in: .scrollView(axis: .horizontal)).minX
            return direction == .trailing ? (minX > 0 ? -minX : 0) : (minX < 0 ? -minX : 0)
        }
    }
    
    // swipe direction
    enum SwipeDirection  {
        case leading
        case trailing
        
        var alignment: Alignment {
            switch self {
            case .leading :
                return .leading
            case .trailing :
                return .trailing
            }
        }
    }
    
    // action model
    struct Action: Identifiable {
        private(set) var id: UUID = .init()
        var isEnable : Bool = true
        var action: () -> ()
    }
    
    @resultBuilder
    struct ActionBuilder {
        static func buildBlock(_ components: Action...) -> [Action] {
            return components
        }
    }
    
    
}
