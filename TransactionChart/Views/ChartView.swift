//
//  ChartView.swift
//  TransactionChart
//
//  Created by Yemi Gabriel on 3/14/22.
//

import SwiftUI


struct ChartView: View {
    @ObservedObject var viewModel: ChartViewModel
    let screenWidth = UIScreen.main.bounds.width
    
    var body: some View {
        VStack {
            ZStack {
                viewModel.path
                    .trim(from: 0, to: viewModel.pathCompletion)
                    .stroke(Color.blue, lineWidth: 2)
                    .gesture(DragGesture().onChanged({ value in
                        withAnimation{
                            viewModel.showDragCircle = true
                        }
                        if viewModel.path.cgPath.contains(value.location) {
                            let location = value.location
                            withAnimation(.easeInOut) {
                                viewModel.moveIndicator(to: location)
                            }
                            //calc index
                            let offsetXWidth: CGFloat = viewModel.chartSize.width / CGFloat(viewModel.chartData.count)
                            let index:Int = Int(round((location.x)/offsetXWidth))
                            withAnimation {
                                viewModel.updateLabel(at: index)
                            }
                        }
                    }).onEnded({ value in
                        withAnimation {
                            viewModel.showDragCircle = false
                        }
                    }))
                    .background(
                        PathGradient(path: viewModel.closedPath)
                    )
                
                    .clipped()
                
                CircleIndicator(dragCirlePosition: viewModel.dragCirlePosition, labelData: viewModel.currentPlotValue)
            }
                
        }
        .onChange(of: viewModel.chartSize, perform: { _ in
            viewModel.drawPaths()
            withAnimation(.easeInOut(duration: 2)) {
                viewModel.pathCompletion = 1.0
            }
            let position = CGPoint(x: viewModel.chartData.first?.x ?? 0, y: viewModel.chartData.first?.y ?? 0)
            viewModel.moveIndicator(to: position)
            viewModel.updateLabel(at: 0)
        })
    }
    
}


struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(viewModel: ChartViewModel())
    }
}
