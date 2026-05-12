//
//  LocalBiometricView.swift
//  WalletFlow
//
//  Created by Gabriel Lopes on 11/05/26.
//

import SwiftUI
import LocalAuthentication

struct LocalBiometricView: View {
    
    @EnvironmentObject var profileVM: ProfileSettingsViewModel
    @State private var isAuthenticated: Bool = false
    @State private var text = "Please authentication"
    
    var body: some View {
        ZStack {
            
            if profileVM.biometricEnable {
                if isAuthenticated {
                    ContentView()
                } else {
                    BiometricView()
                        .onAppear {
                            authenticated()
                        }
                }
            } else {
                ContentView()
            }
        }
    }
    
    func authenticated() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to unlock your data"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, error in
                if let error {
                    print("Error: \(error)")
                    text = error.localizedDescription
                    return
                }
                if success {
                    print("Authentication Success")
                } else {
                    text = "Authentication Failed"
                }
                
                DispatchQueue.main.async {
                    isAuthenticated = success
                }
            }
        }
    }
}
