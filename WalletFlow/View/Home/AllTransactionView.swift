//
//  AllTransactionView.swift
//  WalletFlow
//
//  Created by Gabriel Lopes on 04/05/26.
//

import SwiftUI

struct AllTransactionsView: View {
    
    var transactions: [Transaction]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack {
                ForEach(transactions.sorted(by: { $0.date > $1.date })) { transaction in
                    ItemTransactionView(transaction: transaction)
                }
            }
        }
        .padding()
        .background(.gray.opacity(0.1))
    }
}

#Preview {
    AllTransactionsView(transactions: [
        Transaction(
            type: .income,
            description: "Freelance",
            amount: 1230.00,
            category: .freelance,
            date: mockDate(day: -2)
        ),
        Transaction(
            type: .income,
            description: "Salario",
            amount: 1590.88,
            category: .salary,
            date: mockDate(day: -1)
        ),])
}
