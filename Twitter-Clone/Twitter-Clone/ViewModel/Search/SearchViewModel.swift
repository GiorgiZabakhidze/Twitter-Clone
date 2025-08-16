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
        findUserById()
    }
    
    func fetchUsers() {
        AuthServices.requestDomain = "\(Constants.baseURL)/users"
        
        AuthServices.fetchUser { result in
            switch result {
                case .success(let data):
                    guard let users = try? JSONDecoder().decode([User].self, from: data as! Data) else { return }
                    
                    DispatchQueue.main.async {
                        self.users = users
                        
                        for i in 0..<users.count {
                            UserDefaults.standard.set(users[i].name, forKey: users[i].id)
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
    
    func followerUsers(userId: String) -> [User] {
        return users.filter({ $0.following.contains(userId) })
    }
    
    func followingUsers(userId: String) -> [User] {
        return users.filter({ $0.followers.contains(userId) })
    }
    
    func findUserById() -> [User] {
        print("Find user By Id: ")
        print(AuthViewModel.shared.currentUser!.id)
        for user in users.filter({ $0._id == AuthViewModel.shared.currentUser!.id }) {
            print(user.name)
            print(AuthViewModel.shared.currentUser!.id)
        }
        return users.filter({ $0._id == AuthViewModel.shared.currentUser!.id })
    }
}
