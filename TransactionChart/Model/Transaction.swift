//
//  Transaction.swift
//  TransactionChart
//
//  Created by Yemi Gabriel on 3/14/22.
//

import Foundation

struct Transaction: Identifiable, Decodable {
    let id: String
    let title: String
    let amount: Double
    let currentBalance: Double
    let type: String
    let date: String
    
    var displayedAmount: String {
        "\(type == "credit" ? "": "-")£\(amount)"
    }
    var month: String {
        let date = DateFormatter().date(from: date) ?? .now
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        return dateFormatter.string(from: date)
    }
    
    var time: String {
        let date = DateFormatter().date(from: date) ?? .now
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:MM"
        return dateFormatter.string(from: date)
        
    }
}


