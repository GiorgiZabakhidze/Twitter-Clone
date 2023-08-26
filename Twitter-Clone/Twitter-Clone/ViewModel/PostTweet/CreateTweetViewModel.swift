//
//  CreateTweetViewModel.swift
//  Twitter-Clone
//
//  Created by Macbook Pro on 26/8/23.
//

import SwiftUI

class CreateTweetViewModel: ObservableObject {
    
    func uploadPost(text: String) {
        
        guard let user = AuthViewModel.shared.currentUser else {
            return
        }
        
        RequestServices.requestDomain = "http://localhost:3000/tweets"
        
        RequestServices.postTweet(text: text, user: user.name, username: user.username, userId: user.id) { result in
            print(result)
        }
        
    }
}
