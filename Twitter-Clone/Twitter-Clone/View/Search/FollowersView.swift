//
//  FollowersView.swift
//  Twitter-Clone
//
//  Created by Macbook Pro on 16/9/23.
//

import SwiftUI

struct FollowersView: View {
    @ObservedObject var viewModel = SearchViewModel()
    
    var users: [User] {
        return viewModel.followerUsers()
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
            }.padding(.leading)
            ){ control in
                control.endRefreshing()
            }
        }
    }
}

struct FollowersView_Previews: PreviewProvider {
    static var previews: some View {
        FollowersView()
    }
}
