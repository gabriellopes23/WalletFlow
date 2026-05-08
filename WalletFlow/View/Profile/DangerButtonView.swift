//
//  DangerButtonView.swift
//  WalletFlow
//
//  Created by Gabriel Lopes on 07/05/26.
//

import SwiftUI

// MARK: - DangerButtonView
struct DangerButtonView: View {
    
    var icon: String
    var title: String
    var description: String
    
    var logout: () -> Void
    
    var body: some View {
        Button {
            logout()
        } label: {
            HStack {
                Image(systemName: icon)
                    .frame(width: 40, height: 40)
                    .foregroundStyle(.red)
                    .fontWeight(.semibold)
                    .background(.red.opacity(0.3), in: .rect(cornerRadius: 10))
                
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.red)
                    Text(description)
                        .font(.caption)
                        .fontWeight(.thin)
                        .foregroundStyle(.black)
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.white, in: .rect(cornerRadius: 16))
        }
    }
}
