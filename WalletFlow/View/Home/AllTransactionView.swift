//
//  AllTransactionView.swift
//  WalletFlow
//
//  Created by Gabriel Lopes on 04/05/26.
//

import SwiftUI

struct AllTransactionsView: View {
    
    @EnvironmentObject var transactionVM: TransactionViewModel
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack {
                ForEach(transactionVM.transactions.sorted(by: { $0.date > $1.date })) { transaction in
                    ItemTransactionView(transaction: transaction, action: {} )
                }
            }
        }
        .padding()
        .background(.customBG)
    }
}

#Preview {
    AllTransactionsView()
        .environmentObject(TransactionViewModel(profileVM: ProfileSettingsViewModel()))
}
