//
//  ProfileViewModel.swift
//  Twitter-Clone
//
//  Created by Macbook Pro on 1/9/23.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var user: User
    
    init(user: User) {
        self.user = user
    }
}
