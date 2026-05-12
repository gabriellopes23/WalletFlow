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
    @Published var errorMassage: String = ""
    @Published var showError: Bool = false
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
        let user = UserModel(name: fullName, email: email, password: password)
        
        let enconder = JSONEncoder()
        if let encoder = try? enconder.encode(user) {
            UserDefaults.standard.set(encoder, forKey: "user")
            successRegister = true
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
                    errorMassage = "❌ Invalid email or password"
                    showError = true
                }
            }
        }
    }
}
