//
//  searchUserCell.swift
//  Twitter-Clone
//
//  Created by Macbook Pro on 12/8/23.
//

import SwiftUI
import Kingfisher

struct searchUserCell: View {
    
    let user: User
    
    var body: some View {
        HStack {
            KFImage(URL(string: "\(Constants.baseURL)/users/\(self.user.id)/avatar"))
                .placeholder {
                    Image("Profile")
                        .resizable()
                }
                .resizable()
                .scaledToFit()
                .frame(width: 44, height: 44)
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text(self.user.name)
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                Text("@\(self.user.username)")
                    .foregroundColor(.black)
            }
            
            Spacer(minLength: 0)
        }
    }
}
