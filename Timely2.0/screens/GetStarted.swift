//
//  GetStarted.swift
//  Timely2.0
//
//  Created by Riya Batla on 28/01/24.
//

import SwiftUI

struct GetStarted: View {
    var body: some View {
        NavigationView{
            ZStack{
                Image("grad1")
                    .offset(y: 10)
                VStack{
                    Spacer()
                    StartedCard()
                }
                Image("pet1")
                    .resizable()
                    .frame(width: 265, height: 269)
                    .offset(y: -90)
            }
            .edgesIgnoringSafeArea(.all)
            .background(Color.black)
        }
    }
}

#Preview {
    GetStarted()
}
