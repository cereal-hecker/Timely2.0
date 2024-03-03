//
//  GetStartedView.swift
//  Timely2.0
//
//  Created by Riya Batla on 28/01/24.
//

import SwiftUI

struct GetStartedView: View {
    var body: some View {
        NavigationView{
            ZStack{
                Image("grad1")
                    .offset(y: 10)
                VStack{
                    Spacer()
                    ZStack(alignment: .bottom){
                        UnevenRoundedRectangle(cornerRadii: .init(
                            topLeading: 50,
                            topTrailing: 50),
                            style: .continuous)
                            .frame(height: 393)
                            .foregroundColor(.grey1)
                        VStack(){
                            Text("timely")
                                .font(.system(size: 80).weight(.black))
                                .padding(.bottom, 7)
                            Text("Tardiness is curable")
                                .font(.title2)
                                .bold()
                                .padding(.bottom, 8)
                            Text("Schedule the day and actually follow it")
                                .font(.caption)
                                .opacity(0.6)
                            Text("throughout by taking care of your pet!")
                                .font(.caption)
                                .opacity(0.6)
                            NavigationLink(destination: RootView()
                                .navigationBarBackButtonHidden(true)) {
                                ZStack(alignment: .bottom){
                                    Rectangle()
                                        .fill(.tertiarypurple)
                                        .frame(width: 100, height: 10)
                                    
                                        Text("Get started")
                                    
                                }
                            }
                            .navigationBarBackButtonHidden(true)
                            .padding(.bottom)
                            Image("paw-clip")
                        }
                        .foregroundColor(.white)
                    }
                }
                Image("pet1")
                    .resizable()
                    .frame(width: 265, height: 269)
                    .offset(y: -85)
            }
            .edgesIgnoringSafeArea(.all)
            .background(Color.black)
        }
    }
}

#Preview {
    GetStartedView()
}
