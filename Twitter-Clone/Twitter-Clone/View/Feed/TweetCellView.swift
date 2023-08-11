//
//  TweetCellView.swift
//  Twitter-Clone
//
//  Created by Macbook Pro on 11/8/23.
//

import SwiftUI

struct TweetCellView: View {
    var tweet: String
    var tweetImage: String?
    
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 10) {
                Image("profile_pic")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 55, height: 55)
                    .clipShape(Circle())
                VStack(alignment: .leading, spacing: 10) {
                    Text("zabaxa ")
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    +
                    Text("@Giorgi_Zabakhidze")
                        .foregroundColor(.gray)
                    Text(tweet)
                        .frame(maxHeight: 100, alignment: .top)
                    if let image = tweetImage {
                        GeometryReader { proxy in
                            Image(image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: proxy.frame(in: .global).width, height: 250)
                                .cornerRadius(15)
                            
                        }.frame(height: 250)
                    }
                }
            }
            // Cell Bottom
            HStack(spacing: 50) {
                Button {
                    
                } label: {
                    Image("twitter-reply-outline")
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 16, height: 16)
                }.foregroundColor(.gray)
                
                Button {
                    
                } label: {
                    Image("twitter-retweet")
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 18, height: 15)
                }.foregroundColor(.gray)
                
                Button {
                    
                } label: {
                    Image("twitter-like-outline")
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 18, height: 15)
                }.foregroundColor(.gray)
                
                Button {
                    
                } label: {
                    Image("upload")
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 19, height: 19)
                }.foregroundColor(.gray)
            }
            .padding(.top, 4)
        }
    }
}

struct TweetCellView_Previews: PreviewProvider {
    static var previews: some View {
        TweetCellView(tweet: sampleText)
    }
}

var sampleText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
