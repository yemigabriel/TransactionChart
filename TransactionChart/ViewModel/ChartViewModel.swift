//
//  ChartViewModel.swift
//  TransactionChart
//
//  Created by Yemi Gabriel on 3/14/22.
//

import SwiftUI

class ChartViewModel: ObservableObject {
    var chartSize: CGSize
    var chartData: [CGPoint]
    
    @Published var path = Path()
    @Published var closedPath = Path()
    @Published var currentPlotValue = ""
    @Published var currentIndex = 0
    
    @Published var dragCirlePosition: CGPoint = .zero
    @Published var dragCirleOffset: CGSize = .zero
    @Published var showDragCircle = false
    @Published var pathCompletion: CGFloat = 0.0
    
    @Published var values: [Double] = []
    @Published var labels: [String] = []
    
    @Published var transactions: [Transaction] = []
    
    init(chartSize: CGSize = .zero,
         chartData: [CGPoint] = []) {
        self.chartSize = chartSize
        self.chartData = chartData
        
        transactions = getTransactions()
        values = transactions.map{$0.currentBalance}
        labels = Array(Set(transactions.map{$0.month}))
        
    }
    
    func updateChart(chartSize: CGSize) {
        self.chartSize = chartSize
        self.chartData = getChartData(from: values, for: chartSize)
        self.currentIndex = 0
    }
    
    func moveIndicator(to position: CGPoint) {
        if !chartData.isEmpty {
            dragCirlePosition = CGPoint(x: position.x - chartSize.width/2, y: position.y - chartSize.height/2)
            currentPlotValue = "N\(values[0])"
        }
    }
    
    func updateLabel(at index: Int) {
        if index < values.count - 1 {
            currentIndex = index
            currentPlotValue = "N\(values[index])"
        }
    }
    
    func drawPaths(){
        path = Path(with: chartData, chartSize: chartSize)
        closedPath = Path(with: chartData, chartSize: chartSize, closed: true)
    }
    
    private func getChartData(from values: [Double], for size: CGSize ) -> [CGPoint] {
        let maxY = values.max() ?? 0
        let minY = values.min() ?? 0
        let yAxis = maxY - minY
        
        var chartData: [CGPoint] = [CGPoint]()
        for index in values.indices {
            let xPosition = size.width/CGFloat(values.count) * CGFloat(index + 1)
            let yPosition = CGFloat(1 - ((values[index] - minY) / yAxis)) * size.height
            chartData.append(CGPoint(x: xPosition, y: yPosition))
        }
        
        return chartData
    }
    
    private func getTransactions() -> [Transaction] {
        return Bundle.main.decode("sample.json")
    }
}
