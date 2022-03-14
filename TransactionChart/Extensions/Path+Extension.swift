//
//  Path+Extension.swift
//  TransactionChart
//
//  Created by Yemi Gabriel on 3/14/22.
//

import SwiftUI

extension Path {
    init(with chartData: [CGPoint], chartSize: CGSize, closed: Bool = false) {
        var path = Path()
        if !chartData.isEmpty {
            for index in chartData.indices {
                if index == 0 {
                    path.move(to: CGPoint(x: chartData[index].x, y: chartData[index].y))
                }
                path.addLine(to: CGPoint(x: chartData[index].x, y: chartData[index].y))
            }
            if closed {
                path.addLine(to: CGPoint(x: chartSize.width, y: chartSize.height))
                path.addLine(to: CGPoint(x: 0, y: chartSize.height))
            }
        }
        self = path
    }
}
