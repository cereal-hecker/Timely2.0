//
//  SplineCard.swift
//  Timely2.0
//
//  Created by Riya Batla on 29/01/24.
//

import SplineRuntime
import SwiftUI

let url = URL(string: "https://build.spline.design/aEj3lKxJZBeYrEPKhblR/scene.splineswift")!

struct SplineCard: View {
    var body: some View {
        try? SplineView(sceneFileURL:url)
            .frame(height: 400)
            .contentMargins(.bottom, 100)
    }
}

#Preview {
    SplineCard()
}
