//
//  Feed.swift
//  Twitter-Clone
//
//  Created by Macbook Pro on 11/8/23.
//

import SwiftUI

struct Feed: View {
    
    @ObservedObject var viewModel = FeedViewModel()
    
    let user: User
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 18) {
                
                ForEach(viewModel.tweets) {
                    
                    TweetCellView(viewModel: TweetCellViewModel(tweet: $0))
                    
                    Divider()
                    
                }
                
            }
            .padding(.top)
            .padding(.horizontal)
            .zIndex(0)
        }
                   
    }
}
