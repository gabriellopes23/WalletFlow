//
//  HomeView.swift
//  WalletFlow
//
//  Created by Gabriel Lopes on 04/05/26.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var authVM: AuthenticationViewModel
    @EnvironmentObject var transactionVM: TransactionViewModel
    @EnvironmentObject var profileVM: ProfileSettingsViewModel
    
    @State private var path: [RoutesHome] = []
    @State private var showAddTransaction: Bool = false
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack(alignment: .bottomTrailing) {
                VStack(spacing: 20) {
                    HeaderView(firstLetterName: authVM.firstLetterName)
                    
                    TotalBalanceView(
                        totalBalance: hideOrNotValue(value: transactionVM.totalBalance),
                        totalIncome: hideOrNotValue(value: transactionVM.totalIncome),
                        totalExpense: hideOrNotValue(value: transactionVM.totalExpense)
                    )
                    
                    ListTransactionsView(
                        goToAllTransactions: { path.append(.allTransaction) },
                        recentsTransactions: transactionVM.recentsTransactions,
                        deleteTransaction: { id in transactionVM.deleteTransaction(id: id) }
                    )
                }
                .padding()
                .background(.customBG)
                
                ButtonAddTransaction() {
                    showAddTransaction.toggle()
                }
            }
            .sheet(isPresented: $showAddTransaction, content: {
                AddTransactionView()
                    .presentationDetents([.fraction(0.75)])
                    .presentationCornerRadius(16)
                    .interactiveDismissDisabled(true)
            })
            .navigationDestination(for: RoutesHome.self) { path in
                switch path {
                case .allTransaction:
                    AllTransactionsView()
                        .navigationTitle("All Transactions")
                }
            }
        }
    }
    
    func hideOrNotValue(value: Double) -> String {
        let newValue = value.currencyFormatter()
        
        if profileVM.hideBalanceEnable {
            return String(newValue.map { $0.isNumber || $0.isPunctuation ? "*" : $0 })
        } else {
            return newValue
        }
    }
}

// MARK: - HeadlineView

struct HeaderView: View {
    
    var firstLetterName: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Welcome back")
                    .foregroundStyle(.secondary)
                Text("WalletFlow")
                    .font(.title)
                    .fontWeight(.bold)
            }
            Spacer()
            Text(firstLetterName)
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundStyle(.customPrimary)
                .padding()
                .background(.customPrimary.opacity(0.2), in: .circle)
        }
    }
}

// MARK: - TotalBalanceView
struct TotalBalanceView: View {
    
    var totalBalance: String
    var totalIncome: String
    var totalExpense: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Total Balance")
                .font(.headline)
                .foregroundStyle(.customPrimaryForeground.opacity(0.8))
            Text(totalBalance)
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundStyle(.customPrimaryForeground)
                
            
            HStack {
                ItemBalance(image: "arrow.up.right", title: "Income", value: totalIncome)
                Spacer()
                ItemBalance(image: "arrow.down.forward", title: "Expenses", value: totalExpense)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(.customPrimary, in: .rect(cornerRadius: 16))
    }
}

// MARK: - ItemBalance
struct ItemBalance: View {
    
    var image: String
    var title: String
    var value: String
    
    var body: some View {
        HStack {
            Image(systemName: image)
                .padding()
                .background(.customPrimaryForeground.opacity(0.3), in: .circle)
                .foregroundStyle(.customPrimaryForeground)
            VStack(alignment: .leading) {
                Text(title)
                    .font(.caption)
                    .foregroundStyle(.customPrimaryForeground.opacity(0.8))
                Text(value)
                    .font(.headline)
                    .fontWeight(.heavy)
                    .foregroundStyle(.customPrimaryForeground)
            }
        }
    }
}

// MARK: - ListTransactionsView
struct ListTransactionsView: View {
    
    var goToAllTransactions: () -> Void
    var recentsTransactions: [Transaction]
    var deleteTransaction: (_ id: UUID) -> Void
    
    var body: some View {
        if recentsTransactions.isEmpty {
            ContentUnavailableView("No recentes Transations", systemImage: "wallet.bifold", description: Text("There are no recent transactions available at the moment. Click + to add your transactions."))
        } else {
            HStack {
                Text("Recent Transactions")
                    .font(.headline)
                    .fontWeight(.semibold)
                Spacer()
                Button("View All") {
                    goToAllTransactions()
                }
                .foregroundStyle(.customPrimary)
            }
            
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack {
                    ForEach(recentsTransactions) { transaction in
                        ItemTransactionView(transaction: transaction) {
                            deleteTransaction(transaction.id)
                        }
                    }
                }
            }
        }
    }
}

// MARK: - ButtonAddTransaction
struct ButtonAddTransaction: View {
    
    var showAddTransaction: () -> Void
    
    var body: some View {
        Button {
            showAddTransaction()
        } label: {
            Image(systemName: "plus")
                .padding()
                .foregroundStyle(.customPrimaryForeground)
                .imageScale(.large)
                .background(.customPrimary, in: .circle)
                .padding()
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(TransactionViewModel(profileVM: ProfileSettingsViewModel()))
        .environmentObject(ProfileSettingsViewModel())
        .environmentObject(AuthenticationViewModel())
}
