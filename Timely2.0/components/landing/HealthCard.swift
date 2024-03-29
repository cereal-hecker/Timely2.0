//
//  HealthCard.swift
//  Timely2.0
//
//  Created by Riya Batla on 29/01/24.
//

import SwiftUI

struct HealthCard: View {
    var currentHp: Double // currentHp value between 0 and 1

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(Color.gray.opacity(0.3))
                    .frame(width: geometry.size.width, height: 15)
                    .cornerRadius(15)
                
                Rectangle()
                    .foregroundColor(self.barColor())
                    .frame(width: self.barWidth(geometry: geometry), height: 15)
                    .cornerRadius(15)
            }
        }
    }

    private func barWidth(geometry: GeometryProxy) -> CGFloat {
        let maxWidth = geometry.size.width
        let normalLevel = min(max(self.currentHp,0),1000)
        return CGFloat(normalLevel / 1000) * maxWidth
    }
    
    private func barColor() -> Color {
        let normalLevel = min(max(self.currentHp,0),1000)
        if normalLevel < 300 {
            return .red
        } else if currentHp < 700 {
            return .yellow
        } else {
            return .green
        }
    }
}

#Preview {
    HealthCard(currentHp: 13)
}
