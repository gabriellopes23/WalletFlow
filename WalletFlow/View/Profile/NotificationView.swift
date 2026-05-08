//
//  NotificationView.swift
//  WalletFlow
//
//  Created by Gabriel Lopes on 07/05/26.
//

import SwiftUI

struct NotificationView: View {
    
    @State private var expenseAlert: Bool = false
    @State private var monthlySummary: Bool = false
    
    var body: some View {
        VStack {
            ItemNavigationView(icon: "chart.line.downtrend.xyaxis", title: "Expense Alert", description: "Notify when spending exceeds budget", toggle: $expenseAlert)
            
            ItemNavigationView(icon: "calendar", title: "Monthly Summary", description: "Receive a monthly spending report", toggle: $monthlySummary)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(.gray.opacity(0.1))
    }
}


#Preview {
    NotificationView()
}
