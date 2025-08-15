//
//  TweetCellView.swift
//  Twitter-Clone
//
//  Created by Macbook Pro on 11/8/23.
//

import SwiftUI
import Kingfisher

struct TweetCellView: View {
    
    @StateObject var viewModel: TweetCellViewModel

    var isLiked: Bool {
        return self.viewModel.tweet.isLiked!
    }
    
    
    init(viewModel: TweetCellViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    
    var body: some View {
        ScrollView {
            VStack {
                HStack(alignment: .top, spacing: 10) {
                    
                    if let user = viewModel.user {
                        NavigationLink {
                            UserProfile(user: user)
                        } label: {
                            KFImage(URL(string: "http://192.168.100.114:3000/users/\(self.viewModel.tweet.userId)/avatar"))
                                .placeholder {
                                    Image("Profile")
                                        .resizable()
                                }
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 55, height: 55)
                                .clipShape(Circle())
                        }

                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("\(self.viewModel.tweet.user) ")
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        +
                        Text("@\(self.viewModel.tweet.username)")
                            .foregroundColor(.gray)

                        Text(self.viewModel.tweet.text)
                            .frame(maxHeight: 100, alignment: .top)
                        
                        if viewModel.tweet.image == "true" {
                            GeometryReader { proxy in
                                KFImage(URL(string: "http://192.168.100.114:3000/tweets/\(viewModel.tweet.id)/image"))
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: proxy.frame(in: .global).width, height: 250)
                                    .cornerRadius(15)
                            }
                            .frame(height: 250)
                        }
                    }
                    
                    Spacer()
                    
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
                        isLiked ? self.viewModel.unlike() : self.viewModel.like()
                    } label: {
                        Image(isLiked ? "twitter-like" : "twitter-like-outline")
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 18, height: 15)
                    }.foregroundColor(isLiked ? Color("bg") : .gray)
                    
                    Button {
                        
                    } label: {
                        Image("upload")
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 19, height: 19)
                    }.foregroundColor(.gray)
                }
                .padding(.top, 4)
                .padding(.leading, 30)
            }

        }
    }
}


var sampleText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
