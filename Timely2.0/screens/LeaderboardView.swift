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
                    RankCard(rank: 1, user: "Meowstar101")
                    RankCard(rank: 2, user: "Coolcat22")
                    RankCard(rank: 3, user: "Purrfect78")
                    RankCard(rank: 4, user: "Whiskers99")
                    RankCard(rank: 5, user: "Catniplover")
                    RankCard(rank: 6, user: "Kittycuddles")
                    RankCard(rank: 7, user: "Furryfriend")
                    RankCard(rank: 8, user: "Playfulpaws")
                    RankCard(rank: 9, user: "Catwhisperer")
                    RankCard(rank: 10, user: "Catball")
//                    RankCard(rank: 11, user: "catwhisperer")
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
