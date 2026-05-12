//
//  Help&SuportView.swift
//  WalletFlow
//
//  Created by Gabriel Lopes on 07/05/26.
//

import SwiftUI


var frequentlyQuestions: [FrequentlyQuestions] = [
    FrequentlyQuestions(title: "How do I add a transaction?", description: "Tap the blue + button on the home screen. Fill the description, amount, category, and date, then tap 'Add Transaction'"),
    FrequentlyQuestions(title: "Can I edit or delete a Transaction?", description: "Currently you can view all transactions. Editing and deletion features are coming in a future update."),
    FrequentlyQuestions(title: "How is my balance calculated?", description: "Your balance is the sum all income transactions minus all expense transactions recorded in the app."),
    FrequentlyQuestions(title: "Is my financil data secure?", description: "Yes. All data is encrypted at rest and in transit. We never share your data with third parties."),
    FrequentlyQuestions(title: "How do the Statistic work?", description: "The Statistics page shows your spending breakdown by category and monthly expense overview for the last 6 months."),
]

struct Help_SuportView: View {
    
    @Environment(\.openURL) var openURL
    @State private var isSelected: String = ""
    
    var body: some View {
        ScrollView(.vertical, content: {
            VStack(alignment: .leading, spacing: 15) {
                CustomTitleHelpView(title: "FREQUENTLY ASKED QUESTIONS")
                LazyVStack {
                    ForEach(frequentlyQuestions, id: \.self) { item in
                        VStack(spacing: 15) {
                            Button {
                                if isSelected == "" {
                                    withAnimation {
                                        isSelected = item.id
                                    }
                                }  else {
                                    withAnimation {
                                        isSelected = ""
                                    }
                                }
                            } label: {
                                HStack {
                                    Text(item.title)
                                    Spacer()
                                    Image(systemName: "arrow.down")
                                }
                                .foregroundStyle(.customForeground)
                            }
                            if isSelected == item.id {
                                Text(item.description)
                                    .font(.subheadline)
                                    .foregroundStyle(.gray)
                            }
                        }
                        .modifier(CardModifier())
                    }
                }
                
                CustomTitleHelpView(title: "CONTACT US")
                ItemOptionsProfileView(icon: "envelope", title: "Email Support", description: "support@walletflow.app") {
                    // Add action
                }
                
                CustomTitleHelpView(title: "LEGAL")
                    ItemOptionsProfileView(icon: "text.page", title: "Privacy Policy", description: "How we handle your data") {
                        openURL(URL(string: "https://github.com/gabriellopes23/gabriellopes23.github.io")!)
                    }
            }
            .padding()
        })
        .background(.customBG)
    }
}

// MARK: - CustomTitleHelpView
struct CustomTitleHelpView: View {
    
    var title: String
    var body: some View {
        Text(title)
            .font(.headline)
            .fontWeight(.bold)
            .foregroundStyle(.customForeground)
    }
}
    
    #Preview {
        Help_SuportView()
    }
