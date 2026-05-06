//
//  Utils.swift
//  WalletFlow
//
//  Created by Gabriel Lopes on 04/05/26.
//

import Foundation

extension Date {
    func dateFormatter() -> String {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "MMMM dd, yyyy"
        
        let stringDate = formatter.string(for: self)
        
        return stringDate ?? ""
    }
}

extension Double {
    func currencyFormatter() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        
        return formatter.string(from: self as NSNumber) ?? ""
    }
}

extension Double {
    func porcentFormatter() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        
        return formatter.string(from: self as NSNumber) ?? ""
    }
}
