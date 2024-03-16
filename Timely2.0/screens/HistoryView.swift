//
//  tabletry1.swift
//  timelyNew
//
//  Created by user2 on 29/01/24.
//

import SwiftUI
import FirebaseFirestore

struct HistoryView: View {
    
    @FirestoreQuery var tasks: [UserTask]
    
    init(userId: String) {
        self._tasks = FirestoreQuery(collectionPath: "customer/\(userId)/tasks/")
    }
    var body: some View {
        VStack(alignment: .leading){
            Text("History")
                .font(.largeTitle .bold())
                .foregroundStyle(Color.white)
                .padding()
            List(tasks) { task in
                HistoryRow(task: task)
                    .listRowBackground(Color.grey2)
                    .listRowSeparatorTint(.blue, edges: .bottom)
            }
            .offset(y: -20)
            .scrollContentBackground(.hidden)
        }
        .background(Color.black)
    }
}

struct HistoryRow: View {
    var task: UserTask
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                HStack(spacing: 4) {
                    
                    if task.isCompleted {
                        Image(systemName: "plus")
                            .foregroundColor(.green)
                    } else {
                        Image(systemName: "minus")
                            .foregroundColor(.red)
                    }
                    
                    if task.isCompleted {
                        Text("200")
                            .font(.title)
                            .fontWeight(.heavy)
                            .foregroundStyle(Color.white)
                    } else {
                        Text("100")
                            .font(.headline)
                            .fontWeight(.heavy)
                            .foregroundStyle(Color.white)
                    }
                    Image(systemName: "star.fill")
                        .foregroundColor(Color.orange)
                        .padding(.trailing, 10)
                }
                .frame(width: 100)
                
                VStack(alignment: .leading){
                    Text(task.earlyTime)
                        .font(.headline)
                        .foregroundStyle(Color.white)
                        .multilineTextAlignment(.leading)
                    Text(task.venue)
                        .font(.title2)
                        .foregroundStyle(Color.white)
                        .multilineTextAlignment(.leading)
//                    Text("\(task), \(task.status)")
//                        .font(.caption)
//                        .foregroundStyle(Color.white)
//                        .multilineTextAlignment(.leading)
                }
            }
        }
        .padding(.horizontal,0)
    }
}

#Preview {
    HistoryView(userId: "9JXe54FCMtSx5xwKiic2mTfFctk1")
}


