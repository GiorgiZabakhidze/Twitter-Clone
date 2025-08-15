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
    @Published var userLikedTweets = [Tweet]()
    
    init(user: User) {
        self.user = user
        FetchTweets()
        FetchUserLikedTweets()
        checkIfUserIsCurrentUser()
        CheckIfUserIsFollowed()
    }
    
    func FetchTweets() {
        RequestServices.requestDomain = "http://192.168.100.114:3000/tweets/\(self.user.id)"
        
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
    
    func follow() {
        
        guard let authedUser = AuthViewModel.shared.currentUser else {
            return
        }
        
        RequestServices.requestDomain = "http://192.168.100.114:3000/users/\(self.user.id)/follow"
        
        RequestServices.followingProcess(id: self.user.id) { result in
            print(result)
        }
        
        RequestServices.requestDomain = "http://192.168.100.114:3000/notifications"
        
        RequestServices.sendNotification(username: authedUser.username, notSenderId: authedUser.id, notReceiverId: self.user.id, notificationType: "follow", postText: "", postLikes: ["sdialm"]) { result in
            print("User Has Been Followed")
        }
        
        self.user.isFollowed = true
    }
    
    func unfollow() {
        RequestServices.requestDomain = "http://192.168.100.114:3000/users/\(self.user.id)/unfollow"
        
        RequestServices.followingProcess(id: self.user.id) { result in
            print(result)
            print("User Has Been unfollowed")
        }
        
        self.user.isFollowed = false
    }
    
    func CheckIfUserIsFollowed() {
        self.user.isFollowed = Bool(self.user.followers.contains(AuthViewModel.shared.currentUser!._id))
    }
    
    func FetchUserLikedTweets(){
        RequestServices.requestDomain = "http://192.168.100.114:3000/tweets/liked/\(self.user.id)"
        
        RequestServices.fetchTweets { result in
            switch result {
                case .success(let data):
                    guard let userLikedTweets = try? JSONDecoder().decode([Tweet].self, from: data as! Data) else { return }
                    DispatchQueue.main.async {
                        self.userLikedTweets = userLikedTweets
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
}
