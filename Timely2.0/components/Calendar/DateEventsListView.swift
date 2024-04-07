//
//  DateView.swift
//  Timely2.0
//
//  Created by user2 on 07/04/24.
//

import SwiftUI

struct DaysEventsListView: View {
    @Binding var dateSelected: Date
    @State var tasks : [UserTask]
    
    var body: some View {
        NavigationStack {
            Group {
                let foundEvents = tasks
                    List {
                        ForEach(filteredTasks) { task in
                            ListViewRow(task: task)
                        }
                    }
                
            }
        }
    }
    var filteredTasks: [UserTask] {
            return tasks.filter { task in
                let taskDate = Date(timeIntervalSince1970: task.dateTime)
                return Calendar.current.isDate(taskDate, inSameDayAs: dateSelected)
            }
        }
}


struct ListViewRow: View {
    let task: UserTask
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Text(task.venue)
                        .font(.system(size: 40))
                }
            }
        }
    }
}
