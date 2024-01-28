//
//  Landing.swift
//  Timely2.0
//
//  Created by Riya Batla on 29/01/24.
//

import SwiftUI

struct Landing: View {
    var body: some View {
        VStack{
            UpcomingEventCard()
            SplineCard()
            Spacer()
        }
        .background(.black)
    }
}

#Preview {
    Landing()
}
