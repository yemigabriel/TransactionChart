//
//  AccountsView.swift
//  TransactionChart
//
//  Created by Yemi Gabriel on 3/14/22.
//

import SwiftUI

struct AccountsView: View {
    @StateObject var viewModel = ChartViewModel()
    
    var body: some View {
        VStack {
            GeometryReader { proxy in
                ChartView(viewModel: viewModel)
                    .onAppear {
                        viewModel.updateChart(chartSize: proxy.size)
                    }
            }
            .frame(height: 200)
            .padding(.top, 50)
            
            
            ScrollViewReader { proxy in
                ScrollView(.horizontal) {
                    HStack(spacing: 10) {
                        ForEach(0 ..< viewModel.labels.count) { index in
                            Text(viewModel.transactions[index].month)
                                .id(index)
                                .frame(width: UIScreen.main.bounds.width/3)
                        }
                    }
                    .frame(height: 60)
                }
            }
            
            ScrollViewReader { proxy in
                List{
                    ForEach(0 ..< viewModel.transactions.count) { index in
                        TransactionRow(transaction: viewModel.transactions[index])
                            .id(index)
                            .background(
                                GeometryReader { proxy in
                                    let offset = proxy.frame(in: .named("scroll")).minY
                                    Color.clear.preference(key: OffsetPreferenceKey.self, value: offset)
                                }
                                .frame(height: 0)
                                .background(Color.red)
                            )
                    }
                    
                }
                .coordinateSpace(name: "scroll")
                .onPreferenceChange(OffsetPreferenceKey.self) { value in
                    //TODO: 2-way scroll
                    print(value)
                }
                .listStyle(PlainListStyle())
                .onAppear {
                    print("currentIndex: ", viewModel.currentIndex)
                    withAnimation(.easeInOut(duration: 3)) {
                        proxy.scrollTo(viewModel.currentIndex, anchor: .top)
                    }
                }
                .onChange(of: viewModel.currentIndex, perform: { newValue in
                    print("currentIndex: from onchange ", newValue)
                    withAnimation(.easeInOut(duration: 3)) {
                        proxy.scrollTo(newValue, anchor: .top)
                    }
                })
            }
            Spacer()
        }
    }}

struct AccountsView_Previews: PreviewProvider {
    static var previews: some View {
        AccountsView()
    }
}

struct ScrollViewOffset<Content: View>: View {
  let onOffsetChange: (CGFloat) -> Void
  let content: () -> Content

  init(
    onOffsetChange: @escaping (CGFloat) -> Void,
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.onOffsetChange = onOffsetChange
    self.content = content
  }

  var body: some View {
    ScrollView {
      offsetReader
      content()
        .padding(.top, -8)
    }
    .coordinateSpace(name: "frameLayer")
    .onPreferenceChange(OffsetPreferenceKey.self, perform: onOffsetChange)
  }

  var offsetReader: some View {
    GeometryReader { proxy in
      Color.clear
        .preference(
          key: OffsetPreferenceKey.self,
          value: proxy.frame(in: .named("frameLayer")).minY
        )
    }
    .frame(height: 0)
  }
}

private struct OffsetPreferenceKey: PreferenceKey {
  static var defaultValue: CGFloat = .zero
  static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {}
}

