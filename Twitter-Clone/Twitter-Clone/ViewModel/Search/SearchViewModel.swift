//
//  SearchViewModel.swift
//  Twitter-Clone
//
//  Created by Macbook Pro on 8/9/23.
//

import SwiftUI

class SearchViewModel: ObservableObject {
    
    @Published var users = [User]()
    
    init() {
        fetchUsers()
    }
    
    func fetchUsers() {
        AuthServices.requestDomain = "http://localhost:3000/users"
        
        AuthServices.fetchUser { result in
            switch result {
                case .success(let data):
                    guard let users = try? JSONDecoder().decode([User].self, from: data as! Data) else { return }
                    
                    DispatchQueue.main.async {
                        self.users = users
                        
                        for i in 0..<users.count {
                            UserDefaults.standard.set(users[i].username, forKey: users[i].id)
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    func filteredUsers(_ query: String) -> [User] {
        let lowercaseQuery = query.lowercased()
        
        return users.filter({ $0.name.lowercased().contains(lowercaseQuery) || $0.username.lowercased().contains(lowercaseQuery) })
    }
    
    func followerUsers() -> [User] {
        return users.filter({ $0.following.contains(AuthViewModel.shared.currentUser!.id) })
    }
    
    func followingUsers() -> [User] {
        return users.filter({ $0.followers.contains(AuthViewModel.shared.currentUser!.id) })
    }
}
