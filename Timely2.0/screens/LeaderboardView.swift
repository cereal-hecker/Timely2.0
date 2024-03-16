//
//  LeaderboardView.swift
//  Timely
//
//  Created by Riya Batla on 31/12/23.
//

import SwiftUI
import FirebaseFirestore

struct LeaderboardView: View {
    @FirestoreQuery var users: [User]
    @State private var isLongPressed: Bool = false
    
    
    init() {
        self._users = FirestoreQuery(collectionPath: "customer/")
    }
    var body: some View {
        ZStack(alignment: .top){
            Rectangle()
                .foregroundColor(.black)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: 730)
                .cornerRadius(15)
                .ignoresSafeArea(edges: .top)
            VStack(alignment: .leading){
                Text("Leaderboard")
                    .foregroundColor(.white)
                    .font(.title)
                    .bold()
                    .padding(.leading, 25)
                    .padding(.bottom)
                Spacer()
                ScrollView{
                    LazyVStack(alignment: .leading){
                        ForEach(users.sorted(by: { $0.level > $1.level })) { user in
                            RankCard(rank: user.level, user: user.username)
                        }
                        Spacer()
                    }
                }
            }
        }
        .background(.black)
    }
}

#Preview {
    LeaderboardView()
}
