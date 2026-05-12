//
//  ItemOptionsProfileView.swift
//  WalletFlow
//
//  Created by Gabriel Lopes on 08/05/26.
//

import SwiftUI

// MARK: - ItemOptionsProfileView
struct ItemOptionsProfileView: View {
    
    var icon: String
    var title: String
    var description: String
    
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Image(systemName: icon)
                    .frame(width: 40, height: 40)
                    .foregroundStyle(.gray)
                    .fontWeight(.semibold)
                    .background(.customSecondary, in: .rect(cornerRadius: 10))
                
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Text(description)
                        .font(.caption)
                        .fontWeight(.thin)
                }
                
                Spacer()
                
                Text(">")
                    .foregroundStyle(.customCardForeground)
            }
            .padding()
            .foregroundStyle(.customCardForeground)
            .background(.customCard, in: .rect(cornerRadius: 16))
        }
        
    }
}

