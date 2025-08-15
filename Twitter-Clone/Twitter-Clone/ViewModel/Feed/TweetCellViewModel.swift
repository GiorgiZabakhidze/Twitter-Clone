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
    
    let currentUser: User
    
    init(tweet: Tweet, currentUser: User) {
        self.tweet = tweet
        self.currentUser = currentUser
        self.fetchUser(userId: tweet.userId)
        self.checkIfTweetIsLiked()
    }
    
    func fetchUser(userId: String) {
        AuthServices.requestDomain = "http://192.168.100.114:3000/users/\(userId)"
        
        AuthServices.fetchUser() { result in
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
        RequestServices.requestDomain = "http://192.168.100.114:3000/tweets/\(self.tweet.id)/like"
        
        RequestServices.likeProcess(id: self.tweet.id) { result in
            print(result)
            print("The Tweet Has Been Liked")
        }
        
        RequestServices.requestDomain = "http://192.168.100.114:3000/notifications"
        
        RequestServices.sendNotification(username: self.currentUser.username, notSenderId: self.currentUser.id, notReceiverId: self.tweet.userId, notificationType: "like", postText: self.tweet.text, postLikes: self.tweet.likes) { result in
            
            print("Tweet Has Been Liked")
        }
        
        self.tweet.isLiked = true
    }
    
    func unlike() {
        RequestServices.requestDomain = "http://192.168.100.114:3000/tweets/\(self.tweet.id)/unlike"
        
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
