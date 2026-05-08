//
//  FrequentlyQuestions.swift
//  WalletFlow
//
//  Created by Gabriel Lopes on 07/05/26.
//

import Foundation

struct FrequentlyQuestions: Identifiable, Hashable {
    var id = UUID().uuidString
    var title: String
    var description: String
}
