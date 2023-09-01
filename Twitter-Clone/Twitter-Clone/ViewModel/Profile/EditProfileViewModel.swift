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
        self.UploadComlete.toggle()
    }
     
}
