//
//  ItemNavigationView.swift
//  WalletFlow
//
//  Created by Gabriel Lopes on 07/05/26.
//

import SwiftUI

// MARK: - ItemNavigationView
struct ItemNavigationView: View {
    
    var icon: String
    var title: String
    var description: String
    
    @Binding var toggle: Bool
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .frame(width: 40, height: 40)
                .foregroundStyle(.gray)
                .fontWeight(.semibold)
                .background(.gray.opacity(0.3), in: .rect(cornerRadius: 10))
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text(description)
                    .font(.caption)
                    .fontWeight(.thin)
            }
            
            Toggle("", isOn: $toggle)
        }
        .padding()
        .foregroundStyle(.black)
        .background(.white, in: .rect(cornerRadius: 16))
    }
}
