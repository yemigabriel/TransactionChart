//
//  TransactionRow.swift
//  TransactionChart
//
//  Created by Yemi Gabriel on 3/14/22.
//

import SwiftUI


struct TransactionRow: View {
    let transaction: Transaction
    
    var body: some View {
        HStack {
            Image(systemName:"sterlingsign.square.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 44)
            VStack(alignment: .leading) {
                Text(transaction.title)
                Text(transaction.time)
            }
            Spacer()
            Text(transaction.displayedAmount)
        }
    }
}

