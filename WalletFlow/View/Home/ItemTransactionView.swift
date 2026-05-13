//
//  ItemTransactionView.swift
//  WalletFlow
//
//  Created by Gabriel Lopes on 04/05/26.
//

import SwiftUI

struct ItemTransactionView: View {
    
    @State var dragOffset = CGSize.zero
    @State var position = CGSize.zero
    @State var position2 = CGSize.zero
    
    var transaction: Transaction
    
    var delete: () -> Void
    var edit: () -> Void
    
    var body: some View {
        HStack {
            Image(systemName: transaction.category.icon)
                .frame(width: 40, height: 40)
                .foregroundStyle(transaction.category.foreground)
                .fontWeight(.semibold)
                .background(transaction.category.BG, in: .rect(cornerRadius: 10))
            
            VStack(alignment: .leading) {
                Text(transaction.description)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text(transaction.date.dateFormatter())
                    .font(.caption)
                    .fontWeight(.thin)
            }
            .foregroundStyle(.customCardForeground)
            
            Spacer()
            
            Text(transaction.amount.currencyFormatter())
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(transaction.type == .expense ? .red : .customForeground)
        }
        .padding()
        .background(.customCard, in: .rect(cornerRadius: 16))
        .offset(x: dragOffset.width + position.width)
        .animation(.linear, value: dragOffset)
        .gesture(
            DragGesture()
                .onChanged({ value in
                    dragOffset = value.translation
                    position2.width = dragOffset.width + position.width
                })
                .onEnded({ value in
                    if dragOffset.width < -40 {
                        position.width = -140
                    } else {
                        position.width = 0
                    }
                    position2.width = position.width
                    dragOffset = .zero
                })
        )
        .background(alignment: .trailing) {
            HStack(spacing: 0) {
                Button {
                    withAnimation {
                        position.width = 0
                    }
                    edit()
                } label: {
                    Image(systemName: "pencil")
                        .padding()
                        .foregroundStyle(.customCardForeground)
                        .frame(maxWidth: 70, maxHeight: .infinity)
                        .background(.green, in: .rect(cornerRadius: 16))
                }
                Button {
                    delete()
                } label: {
                    Image(systemName: "trash")
                        .padding()
                        .foregroundStyle(.customCardForeground)
                        .frame(maxWidth: 70, maxHeight: .infinity)
                        .background(.red, in: .rect(cornerRadius: 16))
                }
            }
            .opacity(position.width == -140 ? 1.0 : 0.0)
            .animation(.linear, value: position.width)
        }
    }
}

#Preview {
    ItemTransactionView(transaction: Transaction(id: UUID(), type: .expense, description: "Food", amount: 200, category: .bills, date: .now), delete: {}, edit: {} )
        .background(.black)
}
