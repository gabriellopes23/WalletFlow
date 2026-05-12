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
                .foregroundStyle(transaction.category.foreground)
                .fontWeight(.semibold)
                .background(transaction.category.BG, in: .rect(cornerRadius: 10))
            
            VStack(alignment: .leading) {
                Text(transaction.description)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text(transaction.date.dateFormatter())
                    .font(.caption)
                    .fontWeight(.thin)
            }
            .foregroundStyle(.customCardForeground)
            
            Spacer()
            
            Text(transaction.amount.currencyFormatter())
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(transaction.type == .expense ? .red : .customForeground)
        }
        .padding()
        .background(.customCard, in: .rect(cornerRadius: 16))
    }
}
