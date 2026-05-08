//
//  Privacy&SecurityView.swift
//  WalletFlow
//
//  Created by Gabriel Lopes on 07/05/26.
//

import SwiftUI

struct Privacy_SecurityView: View {
    
    @State private var hideBalance: Bool = false
    @State private var biometricLock: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            VStack(alignment: .leading) {
                Text("DISPLAY")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(.gray)
                ItemNavigationView(icon: "eye", title: "Hide Balance", description: "Mask your balance on the home screen", toggle: $hideBalance)
                
                ItemNavigationView(icon: "touchid", title: "Biometric Lock", description: "Use face ID or fingerprint to unlock", toggle: $biometricLock)
            }
            
            VStack(alignment: .leading) {
                Text("DANGER ZONE")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(.gray)
                DangerButtonView(icon: "trash", title: "Delete all data", description: "Permanently remove all transactions") {
                    
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(.gray.opacity(0.1))
    }
}

#Preview {
    Privacy_SecurityView()
}
