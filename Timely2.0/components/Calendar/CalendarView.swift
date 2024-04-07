//
//  CalendarView.swift
//  Timely2.0
//
//  Created by user2 on 07/04/24.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift

struct CalendarView: View {
    @State var currentDate: Date = Date()
    var userId: String
    @FirestoreQuery var tasks: [UserTask]
    
    init(userId: String) {
        self.userId = userId
        self._tasks = FirestoreQuery(collectionPath: "customer/\(userId)/tasks")
    }
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack(spacing: 20){
                MonthDatePicker(currentDate: $currentDate,userId: userId)
            }
        }
        .padding(.horizontal,2)
        .onChange(of: currentDate){
            
        }
    }
}

#Preview {
    CalendarView(userId: "9JXe54FCMtSx5xwKiic2mTfFctk1")
}
