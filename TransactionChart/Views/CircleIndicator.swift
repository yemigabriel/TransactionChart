//
//  CircleIndicator.swift
//  TransactionChart
//
//  Created by Yemi Gabriel on 3/14/22.
//

import SwiftUI

struct CircleIndicator: View {
    let dragCirlePosition: CGPoint
    let labelData: String
    
    var body: some View {
        Circle()
            .stroke(Color.blue, lineWidth: 5)
            .frame(width: 15, height: 15)
            .offset(x: dragCirlePosition.x, y: dragCirlePosition.y)
            .overlay(
                Text(labelData)
                    .font(.caption)
                    .padding(10)
                    .frame(width: 100)
                    .background(Capsule().fill(Color.gray.opacity(0.2)))
                    .offset(x: dragCirlePosition.x + 20, y: dragCirlePosition.y - 50)
            )
    }
}
struct CircleIndicator_Previews: PreviewProvider {
    static var previews: some View {
        CircleIndicator(dragCirlePosition: .zero, labelData: "preview")
    }
}
