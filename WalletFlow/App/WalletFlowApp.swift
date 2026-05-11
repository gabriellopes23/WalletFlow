//
//  WalletFlowApp.swift
//  WalletFlow
//
//  Created by Gabriel Lopes on 04/05/26.
//

import SwiftUI

@main
struct WalletFlowApp: App {
    
    @StateObject var authVM: AuthenticationViewModel = AuthenticationViewModel()
    @StateObject var profileVM: ProfileSettingsViewModel
    @StateObject var transactionVM: TransactionViewModel
    
    init() {
        let profileVM = ProfileSettingsViewModel()
        
        _profileVM = StateObject(wrappedValue: profileVM)
        _transactionVM = StateObject(wrappedValue: TransactionViewModel(profileVM: profileVM))
    }
    
    var body: some Scene {
        WindowGroup {
            if authVM.isLogged {
                LocalBiometricView()
            } else {
                AuthenticationView()
            }
        }
        .environmentObject(authVM)
        .environmentObject(transactionVM)
        .environmentObject(profileVM)
    }
}
