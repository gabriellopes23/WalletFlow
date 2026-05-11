//
//  AuthenticationView.swift
//  WalletFlow
//
//  Created by Gabriel Lopes on 10/05/26.
//

import SwiftUI

enum Authentication {
    case signin, register
}

struct AuthenticationView: View {
    
    @EnvironmentObject var authVM: AuthenticationViewModel
    
    @State private var isSelectedAuthType: Authentication = .signin
    @State private var fullName: String = ""
    @State private var email: String = "teste@gmail.com"
    @State private var password: String = "123456"
    
    var body: some View {
        VStack(spacing: 30) {
            VStack(spacing: 10) {
                Image(systemName: "wallet.bifold")
                    .padding()
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .frame(width: 80, height: 80)
                    .background(.blue, in: .rect(cornerRadius: 16))
                
                Text("WalletFlow")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Your personal finance manager")
                    .foregroundStyle(.gray)
            }
            
            HStack {
                ItemSegmentedAuthenticationView(isSelected: {
                    withAnimation {
                        isSelectedAuthType = .signin
                    }
                }, color: isSelectedAuthType == .signin ? .white : .clear, title: "Sign In")
                
                ItemSegmentedAuthenticationView(isSelected: {
                    withAnimation {
                        isSelectedAuthType = .register
                    }
                }, color: isSelectedAuthType == .register ? .white : .clear, title: "Register")
            }
            .padding(5)
            .frame(maxWidth: .infinity)
            .background(.gray.opacity(0.15), in: .rect(cornerRadius: 16))
            
            VStack {
                if isSelectedAuthType == .register {
                    CustomTextFieldAuthentication(text: $fullName, titleKey: "Full Name")
                }
                
                CustomTextFieldAuthentication(text: $email, titleKey: "Email")
                CustomTextFieldAuthentication(text: $password, titleKey: "Password")
            }
            
            Button {
                authVM.login(email: email, password: password)
            } label: {
                Text(isSelectedAuthType == .signin ? "Sign In" : "Create Account")
                    .padding()
                    .font(.headline)
                    .fontWeight(.heavy)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .background(.blue, in: .rect(cornerRadius: 16))
            }

        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.gray.opacity(0.1))
    }
}

// MARK: - CustomTextFieldAuthentication
struct CustomTextFieldAuthentication: View {
    
    @Binding var text: String
    var titleKey: String
    
    var body: some View {
        TextField(titleKey, text: $text)
            .padding()
            .background(.white, in: .rect(cornerRadius: 16))
            .overlay {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(.gray.opacity(0.15), lineWidth: 1)
            }
    }
}

// MARK: - ItemSegmentedAddTransaction
struct ItemSegmentedAuthenticationView: View {
    
    var isSelected: () -> Void
    var color: Color
    var title: String
    
    var body: some View {
        Button {
            isSelected()
        } label: {
            Text(title)
                .padding(10)
                .frame(maxWidth: .infinity)
                .foregroundStyle(.black)
                .fontWeight(.semibold)
                .background(color, in: .rect(cornerRadius: 16))
        }
    }
}

#Preview {
    AuthenticationView()
        .environmentObject(AuthenticationViewModel())
}
