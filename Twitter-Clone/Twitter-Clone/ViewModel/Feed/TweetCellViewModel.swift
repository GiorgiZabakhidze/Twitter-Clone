//
//  TweetCellViewModel.swift
//  Twitter-Clone
//
//  Created by Macbook Pro on 29/8/23.
//

import SwiftUI

class TweetCellViewModel: ObservableObject {
    
    @Published var tweet: Tweet
    @Published var user: User?
    
    init(tweet: Tweet) {
        self.tweet = tweet
        self.fetchUser(userId: tweet.user)
        self.checkIfTweetIsLiked()
    }
    
    func fetchUser(userId: String) {
        AuthServices.requestDomain = "http://localhost:3000/users/\(userId)"
        
        AuthServices.fetchUser(id: userId) { result in
            switch result {
                case .success(let data):
                    guard let user = try? JSONDecoder().decode(User.self, from: data as! Data) else { return }
                    DispatchQueue.main.async {
                        self.user = user
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    func like() {
        RequestServices.requestDomain = "http://localhost:3000/tweets/\(self.tweet.id)/like"
        
        RequestServices.likeProcess(id: self.tweet.id) { result in
            print(result)
            print("The Tweet Has Been Liked")
        }
        
        self.tweet.isLiked = true
    }
    
    func unlike() {
        RequestServices.requestDomain = "http://localhost:3000/tweets/\(self.tweet.id)/unlike"
        
        RequestServices.likeProcess(id: self.tweet.id) { result in
            print(result)
            print("The Tweet Has Been unLiked")
        }
        
        self.tweet.isLiked = false
    }
    
    func checkIfTweetIsLiked() {
        self.tweet.isLiked = Bool(self.tweet.likes.contains(AuthViewModel.shared.currentUser!.id))
    }
    
}
