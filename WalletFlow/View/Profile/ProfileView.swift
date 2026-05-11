//
//  ProfileView.swift
//  WalletFlow
//
//  Created by Gabriel Lopes on 07/05/26.
//

import SwiftUI

struct ProfileView: View {
    
    @State private var path: [RoutesProfile] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            ScrollView(.vertical, content: {
                VStack(alignment: .leading, spacing: 20) {
                    
                    HeaderProfileView()
                    
                    ResumeTransactionsView()
                    
                    OptionsProfileView(path: $path)
                    
                    DangerButtonView(icon: "iphone.and.arrow.forward.outward", title: "Log Out", description: "") {
                        // Add Action
                    }
                }
                .padding()
            })
            .background(.gray.opacity(0.1))
            .navigationDestination(for: RoutesProfile.self) { path in
                switch path {
                case .notifications:
                    NotificationView()
                        .navigationTitle("Notifications")
                case .privacy:
                    Privacy_SecurityView()
                        .navigationTitle("Privacy & Security")
                case .help:
                    Help_SuportView()
                        .navigationTitle("Help & Support")
                }
            }
        }
    }
    
    // MARK: - HeaderProfileView
    struct HeaderProfileView: View {
        var body: some View {
            VStack(alignment: .leading, spacing: 20) {
                Text("Profile")
                    .font(.title)
                    .fontWeight(.bold)
                HStack {
                    Image(systemName: "wallet.bifold")
                        .foregroundStyle(.blue)
                        .padding()
                        .background(.blue.opacity(0.3), in: .circle)
                    
                    VStack(alignment: .leading) {
                        Text("Gabriel Lopes")
                            .font(.title3)
                            .fontWeight(.semibold)
                        Text("Teste@gmail.com")
                            .foregroundStyle(.black)
                    }
                }
                .modifier(CardModifier())
            }
        }
    }
    
    // MARK: - ResumeTransactionsView
    struct ResumeTransactionsView: View {
        var body: some View {
            HStack() {
                ItemResumeTransactionsView(value: "13", title: "Transactions")
                CustomResumeDivider()
                ItemResumeTransactionsView(value: "10", title: "Expenses")
                CustomResumeDivider()
                ItemResumeTransactionsView(value: "3", title: "Incomes")
            }
            .modifier(CardModifier())
        }
    }
    
    // MARK: - ItemResumeTransactionsView
    struct ItemResumeTransactionsView: View {
        
        var value: String
        var title: String
        
        var body: some View {
            Spacer()
            VStack {
                Text(value)
                    .font(.title3)
                    .fontWeight(.bold)
                Text(title)
                    .font(.caption)
            }
            Spacer()
        }
    }
    
    // MARK: - CustomResumeDivider
    struct CustomResumeDivider: View {
        var body: some View {
            VStack {
                Rectangle()
                    .frame(width: 1, height: 50)
                    .opacity(0.2)
            }
        }
    }
    
    // MARK: - OptionsProfileView
    struct OptionsProfileView: View {
        
        @Binding var path: [RoutesProfile]
        
        var body: some View {
            VStack {
                ItemOptionsProfileView(icon: "bell", title: "Notificaitons", description: "Manage Alert") {
                    path.append(.notifications)
                }
                
                ItemOptionsProfileView(icon: "shield", title: "Privacy", description: "Security settings") {
                    path.append(.privacy)
                }
                
                ItemOptionsProfileView(icon: "questionmark.circle", title: "Help & Support", description: "FAQs and contact") {
                    path.append(.help)
                }
            }
        }
    }
    
    
    
    
}


#Preview {
    ProfileView()
}
