//
//  AddMission.swift
//  Timely2.0
//
//  Created by Riya Batla on 29/01/24.
//

import SwiftUI

struct AddMission: View {
    @State private var isSheetPresented = false
    
    var body: some View {
        ZStack(alignment: .trailing) {
//            Rectangle()
//                .frame(height: 44)
//                .cornerRadius(15)

            HStack {
                Button("Add Mission") {
                    isSheetPresented.toggle()
                }
                    .padding(.leading, 12)
                    .padding(.trailing, 4)

                Spacer()
                
                HStack{
                    Image(systemName: "plus")
                    Text("10")
                    NavigationLink(destination: LoginView().navigationBarBackButtonHidden(true)) {
                        Image(systemName: "star.fill")
                            .foregroundColor(.primarypink)
                            .padding(.trailing, 12)
                            .padding(.leading, 4)
                    }.navigationBarBackButtonHidden(true)
                }
                
                .navigationBarBackButtonHidden(true)
            }
            .padding()
            .background(.grey2)
            .cornerRadius(10)
            .foregroundColor(.white)
            .font(.title2)
            .sheet(isPresented: $isSheetPresented) {
                NavigationView {
                    MissionSheet()
                        .background(.grey1)
                        .navigationBarItems(
                            trailing:  Button(action:{isSheetPresented.toggle()}){
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.grey7)
                            }
                        ) .navigationBarTitle("Add Mission")
                        .foregroundColor(.white)
                        .environment(\.colorScheme, .dark)
                }
                
            }
        }
    }
}

#Preview {
    AddMission()
}

