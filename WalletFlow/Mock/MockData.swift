//
//  MockData.swift
//  WalletFlow
//
//  Created by Gabriel Lopes on 04/05/26.
//

import Foundation

import Foundation
    
var mockTransactions: [Transaction] = [
    Transaction(
        type: .income,
        description: "Freelance",
        amount: 1230.00,
        category: .freelance,
        date: mockDate(day: -2)
    ),
    Transaction(
        type: .income,
        description: "Salario",
        amount: 1590.88,
        category: .salary,
        date: mockDate(day: -1)
    ),
    Transaction(
        type: .expense,
        description: "Food",
        amount: 50.88,
        category: .food,
        date: mockDate(day: -3)
    ),
    Transaction(
        type: .expense,
        description: "Health",
        amount: 88.89,
        category: .health,
        date: mockDate(day: -4)
    ),
    Transaction(
        type: .expense,
        description: "Shopping",
        amount: 350.78,
        category: .shopping,
        date: mockDate(day: -5)
    ),
    Transaction(
        type: .expense,
        description: "Transport",
        amount: 25.89,
        category: .transport,
        date: mockDate(day: -6)
    ),
    Transaction(
        type: .expense,
        description: "Comida",
        amount: 50.98,
        category: .food,
        date: mockDate(day: -6)
    ),
]

func mockDate(day: Int) -> Date {
    let calendar = Calendar.current
       
    let newDate = calendar.date(byAdding: .day, value: day, to: .now)!
        
    return newDate
}
