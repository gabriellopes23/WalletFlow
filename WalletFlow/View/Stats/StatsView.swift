//
//  StatsView.swift
//  WalletFlow
//
//  Created by Gabriel Lopes on 05/05/26.
//

import SwiftUI
import Charts

struct StatsView: View {
    
    @EnvironmentObject var transactionVM: TransactionViewModel
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 25) {
                HeaderStatisticView()
                
                BalanceView(
                    totalIncome: transactionVM.totalIncome.currencyFormatter(),
                    totalExpense: transactionVM.totalExpense.currencyFormatter()
                )
                
                ChartCircleView(spendingByCategory: transactionVM.spendingByCategory)
                
                ChartProgressView(monthlyExpenses: transactionVM.monthlyExpenses)
            }
            .padding()
        }
        .background(.gray.opacity(0.1))
    }
}

// MARK: - HeaderView
struct HeaderStatisticView: View {
    var body: some View {
        Text("Statistic")
            .font(.title)
            .fontWeight(.bold)
    }
}

// MARK: - BalanceView
struct BalanceView: View {
    
    var totalIncome: String
    var totalExpense: String
    
    var body: some View {
        HStack(spacing: 16) {
            BalanceStatisticItem(title: "Total Income", value: totalIncome)
            
            BalanceStatisticItem(title: "Total Expenses", value: totalExpense)
        }
    }
}

// MARK: - BalanceStatistiItem
struct BalanceStatisticItem: View {
    
    var title: String
    var value: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.caption)
            Text(value)
                .font(.title2)
                .fontWeight(.heavy)
                .foregroundStyle(.green)
        }
        .modifier(StatisticModifier())
    }
}

// MARK: - ChartCircleView
struct ChartCircleView: View {
    
    var spendingByCategory: [CategorySpending]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Spending by Category")
                .font(.title3)
                .fontWeight(.bold)
            
            Chart {
                ForEach(spendingByCategory, id: \.self) { item in
                    SectorMark(angle: .value(item.title, item.amount))
                        .foregroundStyle(item.color)
                }
            }
            .frame(height: 150)
            
            LazyVStack(alignment: .leading, spacing: 8) {
                ForEach(spendingByCategory, id: \.self) { item in
                    ItemChartCircleView(color: item.color, title: item.title, value: item.amount.currencyFormatter(), porcent: item.porcent.porcentFormatter())
                }
            }
        }
        .modifier(StatisticModifier())
    }
}

// MARK: - ItemChartCircleView
struct ItemChartCircleView: View {
    
    var color: Color
    var title: String
    var value: String
    var porcent: String
    
    var body: some View {
        HStack(spacing: 18) {
            Image(systemName: "circle.fill")
                .foregroundStyle(color)
                .imageScale(.small)
            
            Text(title)
            
            Spacer()
            
            Text(value)
                .font(.headline)
            Text(porcent)
                .font(.caption)
                .foregroundStyle(.gray.opacity(0.7))
        }
    }
}

// MARK: - ChartProgressView
struct ChartProgressView: View {
    
    var monthlyExpenses: [MonthlyExpense]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Monthly Expenses")
                .font(.title3)
                .fontWeight(.bold)
            
            LazyVStack {
                ForEach(monthlyExpenses, id: \.self) { item in
                    HStack {
                        Text(item.month)
                            .font(.caption)
                            .foregroundStyle(.gray.opacity(0.7))
                        ProgressView(value: item.porcent)
                            .progressViewStyle(.linear)
                        Spacer()
                        Text(item.amount.currencyFormatter())
                            .font(.headline)
                    }
                }
            }
        }
        .modifier(StatisticModifier())
    }
}

// MARK: - StatisticModifier
struct StatisticModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.white, in: .rect(cornerRadius: 16))
    }
}

#Preview {
    StatsView()
        .environmentObject(TransactionViewModel())
}
