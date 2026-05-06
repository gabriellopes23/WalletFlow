//
//  AddTransactionViewModel.swift
//  WalletFlow
//
//  Created by Gabriel Lopes on 04/05/26.
//

import Foundation

@MainActor
class AddTransactionViewModel: ObservableObject {
    
    @Published var description: String = ""
    @Published var amount: Double = 0.0
    @Published var selectedCategory: TransactionCategory = .bills
    @Published var isSelected: TransactionType = .expense
    @Published var selectedDate: Date = .now
    
    var filterCategories: [TransactionCategory] {
        return TransactionCategory.allCases.filter({ $0.type == isSelected })
    }
    
    func validForm() -> Bool {
        if description.isEmpty && amount == 0.0 {
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
    
    
    func addTransaction() -> Transaction {
        let newTransaction = Transaction(
            type: isSelected,
            description: description,
            amount: amount,
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
}
