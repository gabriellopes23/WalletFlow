//
//  AuthenticationViewModel.swift
//  WalletFlow
//
//  Created by Gabriel Lopes on 11/05/26.
//

import SwiftUI

class AuthenticationViewModel: ObservableObject {
    
    @AppStorage("isLogged") var isLogged: Bool = false
    @Published var firstLetterName: String = ""
    @Published var nameProfile: String = ""
    @Published var emailProfile: String = ""
    @Published var messageInfo: String = ""
    @Published var showMessage: Bool = false
    @Published var successRegister: Bool = false
    
    init() {
        loadUser()
    }
    
    func loadUser() {
        if let data = UserDefaults.standard.data(forKey: "user") {
            let decoder = JSONDecoder()
            
            if let user = try? decoder.decode(UserModel.self, from: data) {
                firstLetterName = String(user.name.first(where: { $0.isLetter })!)
                nameProfile = user.name
                emailProfile = user.email
            }
        }
    }
    
    func register(fullName: String, email: String, password: String) {
        
        if validEmail(email: email) && password.count >= 6 {
            let user = UserModel(name: fullName, email: email, password: password)
            
            let enconder = JSONEncoder()
            if let encoder = try? enconder.encode(user) {
                UserDefaults.standard.set(encoder, forKey: "user")
                successRegister = true
                showMessage = true
                messageInfo = "Registration complete, now log in."
            }
        } else {
            showMessage = true
            messageInfo = "Invalid email or password, please try again!"
        }
    }
    
    func login(email: String, password: String) {
        if let data = UserDefaults.standard.data(forKey: "user") {
            let decoder = JSONDecoder()
            
            if let decoder =  try? decoder.decode(UserModel.self, from: data) {
                if email == decoder.email && password == decoder.password {
                    isLogged = true
                } else {
                    isLogged = false
                    showMessage = true
                    messageInfo = "Invalid email or password, please try again or create an account."
                }
            }
        }
    }
    
    func validEmail(email: String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: email)
    }
}
