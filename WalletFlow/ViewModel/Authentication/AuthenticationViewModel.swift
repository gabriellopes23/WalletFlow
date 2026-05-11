//
//  AuthenticationViewModel.swift
//  WalletFlow
//
//  Created by Gabriel Lopes on 11/05/26.
//

import SwiftUI

class AuthenticationViewModel: ObservableObject {
    
    @AppStorage("isLogged") var isLogged: Bool = false
    
    func login(email: String, password: String) {
        if email == "teste@gmail.com" && password == "123456" {
            isLogged = true
        } else {
            isLogged = false
        }
    }
}
