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
    init() {}
    
    
    
}

struct Schedule: View {
    var userId: String
    @FirestoreQuery var items: [UserTask]

    init(userId: String) {
        self.userId = userId
        self._items = FirestoreQuery(collectionPath: "user/\(userId)/tasks")
    }
    @StateObject var viewModel = ScheduleViewModel()
    
    var body: some View {
        VStack(alignment: .leading){
            HorizontalCalendar()
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
                    EventList(userId: userId)
                }
            }
        }
        .background(.black)
    }
}

#Preview {
    Schedule(userId: "V6faODeEAyeC1oSHuA4YJJ6Jd513")
}
