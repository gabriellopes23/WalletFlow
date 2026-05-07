//
//  HomeView.swift
//  WalletFlow
//
//  Created by Gabriel Lopes on 04/05/26.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var testVM = TesteViewModel()
    
    @EnvironmentObject var transactionVM: TransactionViewModel
    
    @State private var path: [Routes] = []
    @State private var showAddTransaction: Bool = false
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack(alignment: .bottomTrailing) {
                VStack(spacing: 20) {
                    HeaderView()
                    
                    TotalBalanceView(
                        totalBalance: transactionVM.totalBalance.currencyFormatter(),
                        totalIncome: transactionVM.totalIncome.currencyFormatter(),
                        totalExpense: transactionVM.totalExpense.currencyFormatter()
                    )
                    
                    ListTransactionsView(
                        goToAllTransactions: { path.append(.allTransaction) },
                        recentsTransactions: transactionVM.recentsTransactions
                    )
                }
                .padding()
                .background(.gray.opacity(0.1))
                
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
            .navigationDestination(for: Routes.self) { path in
                switch path {
                case .allTransaction:
                    AllTransactionsView()
                        .navigationTitle("All Transactions")
                }
            }
        }
        .onAppear {
            testVM.teste(transactions: transactionVM.transactions)
        }
    }
}

// MARK: - HeadlineView
struct HeaderView: View {
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
            Text("G")
                .font(.headline)
                .padding()
                .background(.blue.opacity(0.3), in: .circle)
        }
    }
}

// MARK: - TotalBalanceView
struct TotalBalanceView: View {
    
    var totalBalance: String
    var totalIncome: String
    var totalExpense: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Total Balance")
                .font(.headline)
                .foregroundStyle(.white.opacity(0.8))
            Text(totalBalance)
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundStyle(.white)
            
            HStack {
                ItemBalance(image: "arrow.up.right", title: "Income", value: totalIncome)
                Spacer()
                ItemBalance(image: "arrow.down.forward", title: "Expenses", value: totalExpense)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(.blue, in: .rect(cornerRadius: 16))
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
                .background(.white.opacity(0.5), in: .circle)
                .foregroundStyle(.white)
            VStack(alignment: .leading) {
                Text(title)
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.8))
                Text(value)
                    .font(.headline)
                    .fontWeight(.heavy)
                    .foregroundStyle(.white)
            }
        }
    }
}

// MARK: - ListTransactionsView
struct ListTransactionsView: View {
    
    var goToAllTransactions: () -> Void
    var recentsTransactions: [Transaction]
    
    var body: some View {
        HStack {
            Text("Recent Transactions")
                .font(.headline)
                .fontWeight(.semibold)
            Spacer()
            Button("View All") {
                goToAllTransactions()
            }
        }
        
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack {
                ForEach(recentsTransactions) { transaction in
                    ItemTransactionView(transaction: transaction)
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
                .foregroundStyle(.white)
                .imageScale(.large)
                .background(.blue, in: .circle)
                .padding()
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(TransactionViewModel())
}
