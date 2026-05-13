//
//  AddTransactionView.swift
//  WalletFlow
//
//  Created by Gabriel Lopes on 04/05/26.
//

import SwiftUI

struct AddTransactionView: View {
    
    @EnvironmentObject var transactionVM: TransactionViewModel
    
    @Environment(\.dismiss) var dismiss
    
    @StateObject private var addTransactionVM: AddTransactionViewModel
    
    var transaction: Transaction?
    
    init(transaction: Transaction? = nil) {
        self.transaction = transaction
        _addTransactionVM = StateObject(wrappedValue: AddTransactionViewModel(transation: transaction))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HeaderAddTransactionView()
            
            SegmentedAddTransactionView(addTransactionVM: addTransactionVM)
            
            FormAddTransactionView(addTransactionVM: addTransactionVM)
            
            ButtonAddTransactionView(selectedTransaction: transaction) {
                if let transaction {
                    let updateTransaction = addTransactionVM.addTransaction(id: transaction.id)
                    transactionVM.updateTransaction(updateTransaction: updateTransaction)
                } else {
                    addTransactionVM.submitTransaction(transactionVM: transactionVM)
                }
                dismiss.callAsFunction()
            }
            .opacity(addTransactionVM.validForm() ? 1.0 : 0.7)
            .disabled(!addTransactionVM.validForm())
            
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.customBG)
    }
}

// MARK: - HeaderAddTransactionView
struct HeaderAddTransactionView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        HStack {
            Text("Add Transaction")
                .font(.title3)
                .fontWeight(.bold)
            Spacer()
            Button {
                dismiss.callAsFunction()
            } label: {
                Image(systemName: "xmark")
                    .foregroundStyle(.gray)
                    .fontWeight(.semibold)
            }
            
        }
    }
}

// MARK: - SegmentedAddTransactionView
struct SegmentedAddTransactionView: View {
    
    @ObservedObject var addTransactionVM: AddTransactionViewModel
    
    var body: some View {
        HStack {
            ItemSegmentedAddTransaction(isSelected: {
                withAnimation {
                    addTransactionVM.changeTransactionType(type: .expense)
                }
            }, color: addTransactionVM.isSelected == .expense ? .white : .clear, title: "Expense")
            
            ItemSegmentedAddTransaction(isSelected: {
                withAnimation {
                    addTransactionVM.changeTransactionType(type: .income)
                }
            }, color: addTransactionVM.isSelected == .income ? .white : .clear, title: "Income")
        }
        .padding(5)
        .frame(maxWidth: .infinity)
        .background(.gray.opacity(0.15), in: .rect(cornerRadius: 16))
    }
}

// MARK: - ItemSegmentedAddTransaction
struct ItemSegmentedAddTransaction: View {
    
    var isSelected: () -> Void
    var color: Color
    var title: String
    
    var body: some View {
        Button {
            isSelected()
        } label: {
            Text(title)
                .padding(10)
                .frame(maxWidth: .infinity)
                .foregroundStyle(.black)
                .fontWeight(.semibold)
                .background(color, in: .rect(cornerRadius: 16))
        }
    }
}

// MARK: - FormAddTransactionView
struct FormAddTransactionView: View {
    
    @ObservedObject var addTransactionVM: AddTransactionViewModel
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Description")
            TextField("e.g. Grocery shopping", text: $addTransactionVM.description)
                .modifier(FormModifier())
            
            Text("Amount ($)")
            TextField("R$0,00", value: $addTransactionVM.amount, format: .currency(code: "BRL"))
                .modifier(FormModifier())
                .keyboardType(.decimalPad)
            
            VStack(alignment: .leading, spacing: 20) {
                Text("Category")
                HStack {
                    Text("Select category")
                    Spacer()
                    Picker("Select category", selection: $addTransactionVM.selectedCategory, content: {
                        ForEach(addTransactionVM.filterCategories, id: \.self) { category in
                            Text(category.title)
                        }
                    })
                    
                }
                .modifier(FormModifier())
                
                
                DatePicker("Date", selection: $addTransactionVM.selectedDate, displayedComponents: .date)
            }
        }
        .background(.customBG)
    }
}

// MARK: - FormModifier
struct FormModifier: ViewModifier {
    func body (content: Content) -> some View {
        content
            .padding(8)
            .frame(maxWidth: .infinity)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 0.2)
            }
    }
}

// MARK: - ButtonAddTransactionView
struct ButtonAddTransactionView: View {
    
    var selectedTransaction: Transaction?
    var addTransaction: () -> Void
    
    var body: some View {
        Button {
            addTransaction()
        } label: {
            Text(selectedTransaction != nil ? "Update Transaction" : "Add Transaction")
                .padding()
                .frame(maxWidth: .infinity)
                .background(.customPrimary, in: .rect(cornerRadius: 16))
                .foregroundStyle(.customPrimaryForeground)
                .font(.headline)
                .fontWeight(.heavy)
            
        }
    }
}

#Preview {
    AddTransactionView()
        .environmentObject(TransactionViewModel(profileVM: ProfileSettingsViewModel()))
}
