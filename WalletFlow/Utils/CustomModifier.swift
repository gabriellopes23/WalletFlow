//
//  CustomModifier.swift
//  WalletFlow
//
//  Created by Gabriel Lopes on 07/05/26.
//

import SwiftUI

// MARK: - CardModifier
struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.white, in: .rect(cornerRadius: 16))
    }
}
