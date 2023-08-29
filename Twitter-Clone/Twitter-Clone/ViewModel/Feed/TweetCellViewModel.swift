//
//  TweetCellViewModel.swift
//  Twitter-Clone
//
//  Created by Macbook Pro on 29/8/23.
//

import SwiftUI

class TweetCellViewModel: ObservableObject {
    
    @Published var tweet: Tweet
    
    init(tweet: Tweet) {
        self.tweet = tweet
    }
    
}
