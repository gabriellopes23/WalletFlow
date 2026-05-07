//
//  WalletFlowApp.swift
//  WalletFlow
//
//  Created by Gabriel Lopes on 04/05/26.
//

import SwiftUI

@main
struct WalletFlowApp: App {
    
    @StateObject private var transactionVM: TransactionViewModel = TransactionViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(transactionVM)
        }
    }
}
