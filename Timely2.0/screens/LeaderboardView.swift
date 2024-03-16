//
//  LeaderboardView.swift
//  Timely
//
//  Created by Riya Batla on 31/12/23.
//

import SwiftUI

struct LeaderboardView: View {
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
                VStack(alignment: .leading){
                    RankCard(rank: 1, user: "meowstar101")
                    RankCard(rank: 2, user: "coolcat22")
                    RankCard(rank: 3, user: "purrfect78")
                    RankCard(rank: 4, user: "whiskers99")
                    RankCard(rank: 5, user: "catniplover")
                    RankCard(rank: 6, user: "kittycuddles")
                    RankCard(rank: 7, user: "furryfriend")
                    RankCard(rank: 8, user: "playfulpaws")
                    RankCard(rank: 9, user: "catwhisperer")
                    RankCard(rank: 10, user: "catball")
                    Spacer()
                }
            }
        }
        .background(.black)
    }
}

#Preview {
    LeaderboardView()
}
