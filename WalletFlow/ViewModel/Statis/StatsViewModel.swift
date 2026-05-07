//
//  StatsViewModel.swift
//  WalletFlow
//
//  Created by Gabriel Lopes on 05/05/26.
//

import SwiftUI

//class StatsViewModel: ObservableObject {
//    
//    @Published var transactions = mockTransactions
//    
//    var totalIncomeStatis: Double {
//        someTransaction(type: .income)
//    }
//    
//    var totalExpenseStatis: Double {
//        someTransaction(type: .expense)
//    }
//    
//    var spendingByCategory: [CategorySpending] {
//        var result: [CategorySpending] = []
//        
//        let allExpensesCategory = TransactionCategory.allCases.filter({ $0.type == .expense })
//        
//        for category in allExpensesCategory {
//            let filterExpense = transactions.filter( { $0.category == category })
//            
//            let someExpensesCategories = filterExpense.reduce(0) { acumulador, expense in
//                acumulador + expense.amount
//            }
//            
//            
//            let partialPorcent = someExpensesCategories / totalExpenseStatis
////            let porcent = partialPorcent * 100
//            
//            result.append(CategorySpending(title: category.title, amount: someExpensesCategories, porcent: partialPorcent, color: category.color))
//        }
//        
//        return result
//    }
//    
//    var mothlyExpenses: [MothlyExpense] {
//        var expenses: [MothlyExpense] = []
//        
//        for month in 0...5 {
//            let calendar = Calendar.current
//            let lastMonths = calendar.date(byAdding: .month, value: -month, to: .now)!
//            
//            let monthYearTarget = calendar.dateComponents([.month, .year], from: lastMonths)
//            
//            let filterTransactions = transactions.filter({ $0.type == .expense })
//            
//            let monthTransaction = filterTransactions.filter({ calendar.dateComponents([.month, .year], from: $0.date) == monthYearTarget })
//            
//            let someTransactions = monthTransaction.reduce(0) { acumulador, transaction in
//                acumulador + transaction.amount
//            }
//            
//            let result = MothlyExpense(month: lastMonths.monthFormatter(), amount: someTransactions, porcent: 0.0)
//            expenses.append(result)
//            
//        }
//        
//        let amounts = expenses.map { $0.amount }
//        guard let maxAmount = amounts.max() else { return [] }
//        
//        let porcent = amounts.map({ $0 / maxAmount })
//        
//        for index in expenses.indices {
//            expenses[index].porcent = porcent[index]
//        }
//        
//        print(expenses)
//        
//        return expenses
//    }
//
//}



