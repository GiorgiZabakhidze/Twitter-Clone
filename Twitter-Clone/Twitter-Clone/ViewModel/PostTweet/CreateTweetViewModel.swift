//
//  CreateTweetViewModel.swift
//  Twitter-Clone
//
//  Created by Macbook Pro on 26/8/23.
//

import SwiftUI

class CreateTweetViewModel: ObservableObject {
    
    func uploadPost(text: String, image: UIImage?) {
        
        guard let user = AuthViewModel.shared.currentUser else {
            return
        }
        
        RequestServices.requestDomain = "http://192.168.100.114:3000/tweets"
        
        RequestServices.postTweet(text: text, user: user.name, username: user.username, userId: user.id) { result in
            if let image = image {
                if let id = result?["_id"]! {
                    ImageUplaoder.uploadImage(paramName: "upload", fileName: "image1", image: image, urlPath: "/uploadTweetImage/\(id)")
                }
            }
        }
        
        
    }
}
