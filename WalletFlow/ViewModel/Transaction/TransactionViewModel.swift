//
//  HomeViewModel.swift
//  WalletFlow
//
//  Created by Gabriel Lopes on 04/05/26.
//

import Foundation

class TransactionViewModel: ObservableObject {
    
    @Published var transactions: [Transaction] = []
    @Published var totalIncome: Double = 0.0
    @Published var totalExpense: Double = 0.0
    @Published var totalBalance: Double = 0.0
    @Published var categories: [TransactionCategory: Double] = [:]
    @Published var monthly: [Date: Double] = [:]
    @Published var monthlySummary: Double = 0.0
    
    @Published var resulmeTotalIncome = 0
    @Published var resulmeTotalExpense = 0
    
    var profileVM: ProfileSettingsViewModel
    let notificationService = NotificationService()
    
    init(profileVM: ProfileSettingsViewModel) {
        self.profileVM = profileVM
        loadTransactions()
        recalculateValues(transactions: transactions)
    }
    
    var recentsTransactions: [Transaction] {
        Array(transactions.sorted(by: { $0.date > $1.date }).prefix(6))
    }
    
    func loadTransactions() {
        if let data = UserDefaults.standard.data(forKey: "transactions") {
            let decoder = JSONDecoder()
            
            if let transationsData = try? decoder.decode([Transaction].self, from: data) {
                transactions = transationsData
            }
        }
    }
    
    func addNewTransaction(transaction: Transaction) {
        transactions.append(transaction)
        saveTransactions()
        recalculateValues(transactions: transactions)
    }
    
    func saveTransactions() {
        let encoder = JSONEncoder()
        
        if let enconded = try? encoder.encode(transactions) {
            UserDefaults.standard.set(enconded, forKey: "transactions")
        }
    }
    
    func recalculateValues(transactions: [Transaction]) {
        
        totalIncome = 0.0
        totalExpense = 0.0
        totalBalance = 0.0
        categories = [:]
        monthly = [:]
        
        for transaction in transactions {
            if transaction.type == .income {
                resulmeTotalIncome += 1
                totalIncome += transaction.amount
            }
            
            if transaction.type == .expense {
                resulmeTotalExpense += 1
                totalExpense += transaction.amount
                
                categories[transaction.category, default: 0.0] += transaction.amount
                
                let calendar = Calendar.current
                let month = calendar.dateComponents([.month, .year], from: transaction.date)
                let monthExpense = calendar.date(from: month) ?? .now
                monthly[monthExpense, default: 0.0] += transaction.amount
            }
            
        }
        
        if profileVM.expenseAlertEnable {
            if totalExpense > profileVM.budgetLimit {
                notificationService.scheduleExpenseAlert()
            }
        }
        
        if profileVM.monthlySummaryEnable {
            notificationService.removePendingNotificaions()
            notificationService.scheduleMonthlySummary(monthly: monthly)
        }
        
        totalBalance = totalIncome - totalExpense
    }
    
    func spendingCategories() -> [CategorySpending] {
        
        var result: [CategorySpending] = []
        
        for category in categories {
            if category.key.type == .expense {
                let value = category.value
                
                var porcent = 0.0
                if totalExpense == 0 {
                    porcent = 0
                } else {
                    porcent = value / totalExpense
                }
                
                let categorySpending = CategorySpending(title: category.key.title, amount: value, porcent: porcent, color: category.key.foreground)
                
                result.append(categorySpending)
            }
        }
        
        return result
    }
    
    func monthlyExpenses() -> [MonthlyExpense] {
        
        var result: [MonthlyExpense] = []
        guard let maxAmount = monthly.values.max() else { return [] }
        
        for month in monthly {
            let porcent = month.value / maxAmount
            
            let monthlyExpense = MonthlyExpense(month: month.key, amount: month.value, porcent: porcent)
            
            result.append(monthlyExpense)
        }
        
        let sortedResult = Array(result.sorted(by: { $0.month > $1.month }).prefix(5))
        
        return sortedResult
    }
    
    func deleteAllData() {
        let data = UserDefaults.standard
        data.removeObject(forKey: "transactions")
    }
}
