//
//  Transaction.swift
//  WalletFlow
//
//  Created by Gabriel Lopes on 04/05/26.
//

import SwiftUI

enum TransactionType {
    case expense, income
}

enum TransactionCategory: CaseIterable {
    case salary, freelance, bills, food, shopping, transport, health, entertainment, othersExpense, othersIncome
    
    var icon: String {
        switch self {
        case .salary:
            "briefcase.fill"
        case .freelance:
            "laptopcomputer"
        case .bills:
            "doc.text.fill"
        case .food:
            "fork.knife"
        case .shopping:
            "gym.bag.fill"
        case .transport:
            "car.fill"
        case .health:
            "heart.fill"
        case .entertainment:
            "gamecontroller.fill"
        case .othersExpense:
            "ellipsis.circle"
        case .othersIncome:
            "ellipsis.circle"
        }
    }
    
    var title: String {
        switch self {
        case .salary:
            "Salary"
        case .freelance:
            "Freelance"
        case .bills:
            "Bills"
        case .food:
            "Food"
        case .shopping:
            "Shooping"
        case .transport:
            "Transport"
        case .health:
            "Health"
        case .entertainment:
            "Entertainment"
        case .othersExpense:
            "Others Expense"
        case .othersIncome:
            "Others Income"
        }
    }
    
    var color: Color {
        switch self {
        case .salary:
            Color.green
        case .freelance:
            Color.cyan
        case .bills:
            Color.yellow
        case .food:
            Color.orange
        case .shopping:
            Color.pink
        case .transport:
            Color.blue
        case .health:
            Color.red
        case .entertainment:
            Color.purple
        case .othersExpense:
            Color.gray
        case .othersIncome:
            Color.gray
        }
    }
    
    var type: TransactionType {
        switch self {
        case .salary:
                .income
        case .freelance:
                .income
        case .bills:
                .expense
        case .food:
                .expense
        case .shopping:
                .expense
        case .transport:
                .expense
        case .health:
                .expense
        case .entertainment:
                .expense
        case .othersExpense:
                .expense
        case .othersIncome:
                .income
        }
    }
}

struct Transaction: Identifiable {
    let id = UUID()
    var type: TransactionType
    var description: String
    var amount: Double
    var category: TransactionCategory
    var date: Date
}
