//
//  AuthViewModel.swift
//  Twitter-Clone
//
//  Created by Macbook Pro on 23/8/23.
//

import SwiftUI

class AuthViewModel: ObservableObject {
    
    @Published var isAuthenticated: Bool = false
    @Published var currentUser: User?
    
    var isNewIdSet: Bool = false
    
    init() {
        let defaults = UserDefaults.standard
        let token = defaults.object(forKey: "jsonwebtoken")
//        print(token)
//        logout()
        if (token != nil) {
            isAuthenticated = true

            if let userId = defaults.object(forKey: "userid") {
                fetchUser(userId: userId as! String)
                print("User Fetched")
            }
        }else {
            isAuthenticated = false
        }
    }
    
    static let shared = AuthViewModel()
    
    func login(email: String, password: String, completion: @escaping () -> Void) {
        let defaults = UserDefaults.standard
        
        AuthServices.requestDomain = "http://localhost:3000/users/login"
        AuthServices.login(email: email, password: password) { result in
            switch result {
                case .success(let data):
                    do {
                        
                        let response = try JSONDecoder().decode(APIResponse.self, from: data)
                        
                        DispatchQueue.main.async {
                            // Process user data
                            defaults.set(response.user.id, forKey: response.user.username)
                            defaults.set(response.user.name, forKey: response.user.id)
                            defaults.set(response.token?.tokens![0].token, forKey: "jsonwebtoken")
                            defaults.set(response.user.id, forKey: "userid")
                            self.isNewIdSet = true
                            print("isNewIdSet: \(self.isNewIdSet)")
                            self.isAuthenticated = true
                            self.currentUser = response.user
                            print("Logged In..")
                        }
                        completion()

                    } catch {
                        print("Decoding Error: \(error)")
                        self.isNewIdSet = false
                        completion()
                    }
                case .failure(let error):
                    self.isNewIdSet = false
                    print("Network Error: \(error.localizedDescription)")
                    completion()
            }
        }
    }

    
    func register(name: String, username: String, email: String, password: String) {
        AuthServices.register(name: name, username: username, email: email, password: password) { result in
            switch result {
                case .success(let data):
                    guard let user = try? JSONDecoder().decode(User.self, from: data as! Data) else {
                        print("rr")
                        return
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    func fetchUser(userId: String) {
        AuthServices.requestDomain = "http://localhost:3000/users/\(userId)"
        AuthServices.fetchUser() { result in
            switch result {
                case.success(let data):
                    guard let user = try? JSONDecoder().decode(User.self, from: data as! Data) else {
                        return
                    }
                    DispatchQueue.main.async {
                        UserDefaults.standard.set(user.id, forKey: "userid")
                        self.isAuthenticated = true
                        self.currentUser = user
                        print(user)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    func logout() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        
        dictionary.keys.forEach { key in
            if (key == "jsonwebtoken" || key == "userid") {
                defaults.removeObject(forKey: key)
            }
        }
        
        DispatchQueue.main.async {
            self.isAuthenticated = false
        }
    }
}

