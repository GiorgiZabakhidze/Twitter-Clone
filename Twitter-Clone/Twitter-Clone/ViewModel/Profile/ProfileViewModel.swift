//
//  ProfileViewModel.swift
//  Twitter-Clone
//
//  Created by Macbook Pro on 1/9/23.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var user: User
    @Published var tweets = [Tweet]()
    
    init(user: User) {
        self.user = user
        FetchTweets()
        checkIfUserIsCurrentUser()
    }
    
    func FetchTweets() {
        RequestServices.requestDomain = "http://localhost:3000/tweets/\(self.user.id)"
        
        RequestServices.fetchTweets { result in
            switch result {
                case .success(let data):
                    guard let tweets = try? JSONDecoder().decode([Tweet].self, from: data as! Data) else { return }
                    DispatchQueue.main.async {
                        self.tweets = tweets
                    }
                case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func checkIfUserIsCurrentUser() {
        self.user.isCurrentUser = Bool(self.user._id == AuthViewModel.shared.currentUser?._id)
    }
    
}
