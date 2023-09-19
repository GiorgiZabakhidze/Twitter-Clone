//
//  FollowingsView.swift
//  Twitter-Clone
//
//  Created by Macbook Pro on 16/9/23.
//

import SwiftUI

struct FollowingsView: View {
    @ObservedObject var viewModel = SearchViewModel()
    
    let user: User
    
    var users: [User] {
        return viewModel.followingUsers(userId: user.id)
    }
    
    var body: some View {
        VStack(alignment: .center) {
            Text("\(users.count) Followers")
                .fontWeight(.heavy)
                .foregroundColor(Color("bg"))
            
            RefreshableScrollView(content:
                LazyVStack {
                    ForEach(users) { user in
                        NavigationLink {
                            UserProfile(user: user)
                        } label: {
                            searchUserCell(user: user)
                        }
                    }
                }
                .padding(.leading)
                .padding(.top)
            ){ control in
                control.endRefreshing()
            }.padding(.top)
        }
    }
}

