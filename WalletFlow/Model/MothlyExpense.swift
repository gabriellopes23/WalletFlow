//
//  MothlyExpense.swift
//  WalletFlow
//
//  Created by Gabriel Lopes on 05/05/26.
//

import Foundation

struct MothlyExpense: Hashable, Comparable {
    static func < (lhs: MothlyExpense, rhs: MothlyExpense) -> Bool {
        return lhs.amount < rhs.amount
    }
    
    
    var month: String
    var amount: Double
    var porcent: Double
}
