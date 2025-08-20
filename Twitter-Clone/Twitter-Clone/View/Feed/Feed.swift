//
//  Feed.swift
//  Twitter-Clone
//
//  Created by Macbook Pro on 11/8/23.
//

import SwiftUI

struct Feed: View {
    
    @StateObject var viewModel = FeedViewModel()
    
    let user: User
    
    var body: some View {
        
        RefreshableScrollView(content:
            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: 18) {
                    
                    ForEach(viewModel.tweets) {
                        
                        TweetCellView(viewModel: TweetCellViewModel(tweet: $0, currentUser: user))
                        
                        Divider()
                        
                    }
                    
                }
                .padding(.top)
                .padding(.horizontal)
                .zIndex(0)
                .ignoresSafeArea(.keyboard)
        }) { control in
            DispatchQueue.main.async {
                self.viewModel.fetchTweets()
                control.endRefreshing()
                print("y")
            }
        }
                   
    }
}
