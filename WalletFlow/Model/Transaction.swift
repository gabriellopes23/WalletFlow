//
//  Transaction.swift
//  WalletFlow
//
//  Created by Gabriel Lopes on 04/05/26.
//

import SwiftUI

enum TransactionType: Codable {
    case expense, income
}

enum TransactionCategory: CaseIterable, Codable {
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
    
    var BG: Color {
        switch self {
        case .salary:
            Color.salaryBG
        case .freelance:
            Color.freelanceBG
        case .bills:
            Color.billsBG
        case .food:
            Color.foodBG
        case .shopping:
            Color.shoppingBG
        case .transport:
            Color.transportBG
        case .health:
            Color.healthBG
        case .entertainment:
            Color.entertainmentBG
        case .othersExpense:
            Color.otherBG
        case .othersIncome:
            Color.otherBG
        }
    }
    
    var foreground: Color {
        switch self {
        case .salary:
            Color.salaryForeground
        case .freelance:
            Color.freelanceForeground
        case .bills:
            Color.billsForeground
        case .food:
            Color.foodForeground
        case .shopping:
            Color.shoppingForeground
        case .transport:
            Color.transportForeground
        case .health:
            Color.healthForeground
        case .entertainment:
            Color.entertainmentForeground
        case .othersExpense:
            Color.otherForeground
        case .othersIncome:
            Color.otherForeground
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

struct Transaction: Codable, Identifiable {
    var id = UUID()
    var type: TransactionType
    var description: String
    var amount: Double
    var category: TransactionCategory
    var date: Date
}
