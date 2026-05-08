//
//  MothlyExpense.swift
//  WalletFlow
//
//  Created by Gabriel Lopes on 05/05/26.
//

import Foundation

struct MonthlyExpense: Hashable, Comparable {
    static func < (lhs: MonthlyExpense, rhs: MonthlyExpense) -> Bool {
        return lhs.amount < rhs.amount
    }
    
    
    var month: Date
    var amount: Double
    var porcent: Double
}
