//
//  TesteViewModel.swift
//  WalletFlow
//
//  Created by Gabriel Lopes on 06/05/26.
//

import Foundation

class TesteViewModel: ObservableObject {
    
    @Published var income: Double = 0.0
    @Published var expense: Double = 0.0
    @Published var total: Double = 0.0
    @Published var categories: [TransactionCategory: Double] = [:]
    @Published var monthly: [String: Double] = [:]
    
    func teste(transactions: [Transaction]) {
        
        income = 0.0
        expense = 0.0
        total = 0.0
        categories = [:]
        monthly = [:]
        
        for transaction in transactions {
            if transaction.type == .income {
                income += transaction.amount
            }
            
            if transaction.type == .expense {
                expense += transaction.amount
                
                categories[transaction.category, default: 0.0] += transaction.amount
                
                let calendar = Calendar.current
                let month = calendar.dateComponents([.month, .year], from: transaction.date)
                let monthString = calendar.date(from: month) ?? .now
                monthly[monthString.monthFormatter(), default: 0.0] += transaction.amount
            }
            
        }
        
        total = income - expense
    }
    
    func spendingCategories() -> [CategorySpending] {
        
        var result: [CategorySpending] = []
        
        for category in categories {
            if category.key.type == .expense {
                let value = category.value
                
                var porcent = 0.0
                if expense == 0 {
                    porcent = 0
                } else {
                    porcent = value / expense
                }
                
                let categorySpending = CategorySpending(title: category.key.title, amount: value, porcent: porcent, color: category.key.color)
                
                result.append(categorySpending)
            }
        }

        return result
    }
    
    func monthlyExpenses() -> [MonthlyExpense] {
        
        var result: [MonthlyExpense] = []
        
        for month in monthly {
            guard let maxAmount = monthly.values.max() else { return [] }
            
            let porcent = month.value / maxAmount
            
            let monthlyExpense = MonthlyExpense(month: month.key, amount: month.value, porcent: porcent)
            
            result.append(monthlyExpense)
        }
        
        return result
    }
}
