//
//  FollowersView.swift
//  Twitter-Clone
//
//  Created by Macbook Pro on 16/9/23.
//

import SwiftUI

struct FollowersView: View {
    @ObservedObject var viewModel = SearchViewModel()
    
    let user: User
    
    var users: [User] {
        return viewModel.followerUsers(userId: user.id)
    }
    
    var body: some View {
        VStack(alignment: .center) {
            Text("\(users.count) Followers")
                .fontWeight(.heavy)
                .foregroundColor(Color("bg"))
                .padding(.top)
            
            RefreshableScrollView(content:
                LazyVStack {
                    ForEach(users) { user in
                        NavigationLink {
                            UserProfile(user: user)
                        } label: {
                            searchUserCell(user: user)
                        }
                    }
                }.padding(.leading)
            ){ control in
                control.endRefreshing()
            }
            
            Spacer(minLength: 0)
        }
    }
}


