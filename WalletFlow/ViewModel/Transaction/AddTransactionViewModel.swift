//
//  AddTransactionViewModel.swift
//  WalletFlow
//
//  Created by Gabriel Lopes on 04/05/26.
//

import Foundation

@MainActor
class AddTransactionViewModel: ObservableObject {
    
    @Published var description: String
    @Published var amount: Double?
    @Published var selectedCategory: TransactionCategory
    @Published var isSelected: TransactionType
    @Published var selectedDate: Date
    
    init(transation: Transaction? = nil) {
        description = transation?.description ?? ""
        amount = transation?.amount ?? nil
        selectedCategory = transation?.category ?? .bills
        isSelected = transation?.type ?? .expense
        selectedDate = transation?.date ?? .now
    }
    
    var filterCategories: [TransactionCategory] {
        return TransactionCategory.allCases.filter({ $0.type == isSelected })
    }
    
    func validForm() -> Bool {
        if description.isEmpty || amount == 0.0 {
            return false
        } else {
            return true
        }
    }
    
    func changeTransactionType(type: TransactionType) {
        isSelected = type
        
        if let firstCategory = filterCategories.first {
            selectedCategory = firstCategory
        }
    }
    
    func addTransaction(id: UUID?) -> Transaction {
        let newTransaction = Transaction(
            id: id ?? UUID(),
            type: isSelected,
            description: description,
            amount: amount ?? 0.0,
            category: selectedCategory,
            date: selectedDate)
        
        return newTransaction
    }
    
    func resetFields() {
        description = ""
        amount = 0.0
        selectedDate = .now
        changeTransactionType(type: .expense)
    }
    
    func submitTransaction(transactionVM: TransactionViewModel) {
        transactionVM.addNewTransaction(transaction: addTransaction(id: nil))
        resetFields()
    }
}
