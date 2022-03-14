//
//  ContentView.swift
//  TransactionChart
//
//  Created by Yemi Gabriel on 3/14/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            AccountsView()
                .tabItem {
                    Label("Accounts", systemImage: "wallet.pass")
                }
            
            Text("Analytics")
                .tabItem {
                    Label("Analytics", systemImage: "chart.bar.fill")
                }
            
            Text("Payments")
                .tabItem {
                    Label("Payments", systemImage: "arrow.left.arrow.right")
                }
            
            Text("Cards")
                .tabItem {
                    Label("Cards", systemImage: "creditcard.fill")
                }
            
            Text("More")
                .tabItem {
                    Label("More", systemImage: "ellipsis")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
