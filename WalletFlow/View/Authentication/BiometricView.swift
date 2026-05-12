//
//  BiometricView.swift
//  WalletFlow
//
//  Created by Gabriel Lopes on 11/05/26.
//

import SwiftUI

struct BiometricView: View {
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "wallet.bifold")
                .padding()
                .foregroundStyle(.white)
                .font(.largeTitle)
                .fontWeight(.semibold)
                .frame(width: 80, height: 80)
                .background(.blue, in: .rect(cornerRadius: 16))
            
            Text("WalletFlow")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Your personal finance manager")
                .foregroundStyle(.gray)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.customBG)
    }
}

#Preview {
    BiometricView()
}
