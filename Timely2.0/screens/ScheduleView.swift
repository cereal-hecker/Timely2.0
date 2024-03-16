//
//  Schedule.swift
//  Timely2.0
//
//  Created by Riya Batla on 28/01/24.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

class ScheduleViewModel: ObservableObject {
    @State var userId: String
    
    init() {
        guard let userId = Auth.auth().currentUser?.uid else {
            self.userId = "" // Provide a default value in case currentUser is nil
            return
        }
        self.userId = userId
    }
    
}

struct Schedule: View {
    @StateObject var viewModel = ScheduleViewModel()
    
    var body: some View {
        VStack(alignment: .leading){
            HorizontalCalendar()
                .padding(0)
            ZStack(alignment: .top){
                UnevenRoundedRectangle(cornerRadii: .init(
                    topLeading: 50,
                    topTrailing: 50),
                                       style: .continuous)
                .foregroundColor(.grey1)
                VStack{
                    TagBar()
                        .padding(.top, 25)
                        .padding(.bottom, 10)
                    EventList(userId: viewModel.userId)
                }
            }
        }
        .background(.black)
    }
}

#Preview {
    Schedule()
}
