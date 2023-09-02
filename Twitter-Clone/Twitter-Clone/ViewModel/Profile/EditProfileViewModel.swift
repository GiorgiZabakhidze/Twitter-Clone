//
//  EditProfileViewModel.swift
//  Twitter-Clone
//
//  Created by Macbook Pro on 1/9/23.
//

import SwiftUI

class EditProfileViewModel: ObservableObject {
    var user: User
    
    @Published var UploadComlete: Bool = false
    
    init(user: User) {
        self.user = user
    }
    
    func save(name: String?, location: String?, bio: String?, website: String?) {
        guard let userNewName = name else { return }
        guard let userNewLocation = location else { return }
        guard let userNewBio = bio else { return }
        guard let userNewWebsite = website else { return }
        
        self.user.name = userNewName
        self.user.location = userNewLocation
        self.user.bio = userNewBio
        self.user.website = userNewWebsite
    }
    
    func uploadProfileImage(text: String, image: UIImage?) {
        guard let user = AuthViewModel.shared.currentUser else { return }
        
        let urlPath = "/users/me/avatar"
        
        if let image = image {
            ImageUplaoder.uploadImage(paramName: "avatar", fileName: "image1", image: image, urlPath: urlPath)
        }
    }
     
    func uploadUserData(name: String?, location: String?, bio: String?, website: String?) {
        let userId = user.id
        
        let urlPath = "/users/\(userId)"
        
        let url = URL(string: "http://localhost:3000\(urlPath)")!
        
        AuthServices.makePatchRequestWithAuth(urlString: url, reqBody: ["name": name, "location": location, "bio": bio, "website": website]) { result in
            
            DispatchQueue.main.async {
                self.save(name: name, location: location, bio: bio, website: website)
                self.UploadComlete = true
            }
            
        }
    }
    
}
