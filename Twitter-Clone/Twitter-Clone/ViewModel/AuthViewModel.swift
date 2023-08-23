//
//  AuthViewModel.swift
//  Twitter-Clone
//
//  Created by Macbook Pro on 23/8/23.
//

import SwiftUI

class AuthViewModel: ObservableObject {
    func login() {
        
    }
    
    func logout() {
        
    }
    
    func register(name: String, username: String, email: String, password: String) {
        AuthServices.register(name: name, username: username, email: email, password: password) { result in
            switch result {
                case .success(let data):
                    guard let user = try? JSONDecoder().decode(APIResponse.self, from: data as! Data) else {
                        return
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
}

