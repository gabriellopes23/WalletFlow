//
//  NotificationSettingsViewModel.swift
//  WalletFlow
//
//  Created by Gabriel Lopes on 08/05/26.
//

import SwiftUI

class ProfileSettingsViewModel: ObservableObject {
    @AppStorage("expenseAlertEnable") var expenseAlertEnable: Bool = false
    @AppStorage("monthlySummaryEnable") var monthlySummaryEnable: Bool = false
    @AppStorage("budgetLimit") var budgetLimit: Double = 0.0
    @AppStorage("biometricEnable") var biometricEnable: Bool = true
    @AppStorage("hideBalanceEnable") var hideBalanceEnable: Bool = false
}
