//
//  ItemTransactionView.swift
//  WalletFlow
//
//  Created by Gabriel Lopes on 04/05/26.
//

import SwiftUI

struct ItemTransactionView: View {
    
    var transaction: Transaction
    
    var body: some View {
        HStack {
            Image(systemName: transaction.category.icon)
                .frame(width: 40, height: 40)
                .foregroundStyle(transaction.category.color)
                .fontWeight(.semibold)
                .background(transaction.category.color.opacity(0.3), in: .rect(cornerRadius: 10))
            
            VStack(alignment: .leading) {
                Text(transaction.description)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text(transaction.date.dateFormatter())
                    .font(.caption)
                    .fontWeight(.thin)
            }
            
            Spacer()
            
            Text(transaction.amount.currencyFormatter())
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(transaction.type == .expense ? .red : .primary)
        }
        .padding()
        .background(.white, in: .rect(cornerRadius: 16))
    }
}
