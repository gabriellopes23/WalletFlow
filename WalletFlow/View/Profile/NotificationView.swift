//
//  NotificationView.swift
//  WalletFlow
//
//  Created by Gabriel Lopes on 07/05/26.
//

import SwiftUI

struct NotificationView: View {

    @EnvironmentObject var profileVM: ProfileSettingsViewModel
    
    let notificationservice = NotificationService()
    
    var body: some View {
        VStack(spacing: 15) {
            VStack(alignment: .leading, spacing: 15) {
                ItemNavigationView(icon: "chart.line.downtrend.xyaxis", title: "Expense Alert", description: "Notify when spending exceeds budget", toggle: $profileVM.expenseAlertEnable)
                    .onChange(of: profileVM.expenseAlertEnable) { oldValue, newValue in
                        notificationservice.authorizeNotification()
                    }
                
                if profileVM.expenseAlertEnable {
                        CustomTitleHelpView(title: "Budget Limit")
                        TextField("", value: $profileVM.budgetLimit, format: .currency(code: "BRL"))
                        .modifier(CardModifier())
                        .animation(.bouncy.delay(0.2), value: profileVM.expenseAlertEnable)
                }
                
            }
            
            ItemNavigationView(icon: "calendar", title: "Monthly Summary", description: "Receive a monthly spending report", toggle: $profileVM.monthlySummaryEnable)
                .onChange(of: profileVM.monthlySummaryEnable) { oldValue, newValue in
                    notificationservice.authorizeNotification()
                }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(.gray.opacity(0.1))
    }
}


#Preview {
    NotificationView()
        .environmentObject(ProfileSettingsViewModel())
}
