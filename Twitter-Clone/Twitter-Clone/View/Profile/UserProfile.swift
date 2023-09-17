//
//  UserProfile.swift
//  Twitter-Clone
//
//  Created by Macbook Pro on 13/8/23.
//

import SwiftUI
import Kingfisher

struct UserProfile: View {
    
    let user: User
    
    @ObservedObject var viewModel: ProfileViewModel
    
    @ObservedObject var searchViewModel = SearchViewModel()
    
    var isCurrentUser: Bool {
        return viewModel.user.isCurrentUser!
    }
    
    var isFollowed: Bool {
        return viewModel.user.isFollowed!
    }
    
    
    @State var EditProfileShow: Bool = false
    @State var offset: CGFloat = 0
    @State var titleOffset: CGFloat = 0
    @State var currentTab = "Tweets"
    @State var tabBarOffset: CGFloat = 0
    
    @Namespace var animation
    
    init(user: User) {
        self.user = user
        self.viewModel = ProfileViewModel(user: user)
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 15) {
                GeometryReader { proxy -> AnyView in
                    let minY = proxy.frame(in: .global).minY
                    
                    DispatchQueue.main.async {
                        self.offset = minY
                    }
                    
                    return AnyView(
                        ZStack {
                            Image("banner")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: UIScreen.main.bounds.width, height: minY > 0 ? 180 + minY : 180)
                                .cornerRadius(0)
                            BlurView()
                                .opacity(blurViewOpacity())
                            VStack(spacing: 5) {
                                Text(user.name)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                Text("\(self.viewModel.tweets.count) Tweets")
                                    .foregroundColor(.white)
                            }
                            .offset(y: 120)
                            .offset(y: titleOffset > 100 ? 0 : -getTitleOffset())
                            .opacity(titleOffset < 100 ? 1 : 0)
                        }
                        .clipped()
                        .frame(height: minY > 0 ? 180 + minY : nil)
                        .offset(y: minY > 0 ? -minY : -minY < 80 ? 0 : -minY - 80)
                            
                    )
                }
                .frame(height: 180)
                .zIndex(1)
                
                VStack {
                    HStack {
                        KFImage(URL(string: "http://localhost:3000/users/\(self.viewModel.user.id)/avatar"))
                            .placeholder {
                                Image("Profile")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 75, height: 75)
                                    .clipShape(Circle())
                            }
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 75, height: 75)
                            .clipShape(Circle())
                            .padding(8)
                            .background(Color.white.clipShape(Circle()))
                            .offset(y: offset < 0 ? getOffset() - 20 : -20)
                            .scaleEffect(getScale())
                            .onTapGesture {
                                self.EditProfileShow.toggle()
                            }
                        
                        Spacer()
                        
                        if (self.isCurrentUser) {
                            Button {
                                self.EditProfileShow.toggle()
                            } label: {
                                Text("Edit Profile")
                                    .foregroundColor(.blue)
                                    .padding(.vertical, 10)
                                    .padding(.horizontal)
                                    .background(Capsule()
                                        .stroke(Color.blue, lineWidth: 1.5))
                            }
                            .sheet(isPresented: $EditProfileShow) {
                                UserProfile(user: user)
                            } content: {
                                EditProfileView(user: $viewModel.user)
                            }
                        }else {
                            Button {
                                isFollowed ? self.viewModel.unfollow() : self.viewModel.follow()
                            } label: {
                                Text(isFollowed ? "Following" : "Follow")
                                    .foregroundColor(isFollowed ? .black : .white)
                                    .padding(.vertical, 10)
                                    .padding(.horizontal)
                                    .background(
                                        ZStack {
                                            
                                            Capsule()
                                                .stroke(Color.black, lineWidth: isFollowed ? 1.5 : 0)
                                                .foregroundColor(isFollowed ? .white : .black)
                                            
                                            Capsule()
                                                .foregroundColor(isFollowed ? .white : .black)
                                        }
                                    )
                            }

                        }

                    }
                    .padding(.top, -25)
                    .padding(.bottom, -10)
                    
                    HStack {
                        VStack(alignment: .leading, spacing:  8) {
                            let name = UserDefaults.standard.string(forKey: user.id)!
                            Text(name)
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                            
                            Text("@\(self.viewModel.user.username)")
                                .foregroundColor(.gray)
                            
                            Text(self.viewModel.user.bio ?? "Let everything go, see what stays back. That’s yours.")
                            
                            HStack(spacing: 8) {
                                if let userLocation = viewModel.user.location {
                                    if (userLocation != "") {
                                        HStack(spacing: 2) {
                                            Image(systemName: "mappin.circle.fill")
                                                .frame(width: 24, height: 24)
                                                .foregroundColor(.gray)
                                            
                                            Text(userLocation)
                                                .foregroundColor(.gray)
                                                .font(.system(size: 14))
                                        }
                                    }
                                }
                                
                                if let userWebsite = viewModel.user.website {
                                    if (userWebsite != "") {
                                        HStack(spacing: 2) {
                                            Image(systemName: "link")
                                                .frame(width: 24, height: 24)
                                                .foregroundColor(.gray)
                                            
                                            Text(userWebsite)
                                                .foregroundColor(.cyan)
                                                .font(.system(size: 14))
                                        }
                                    }
                                }
                                
                            }
                            
                            HStack(spacing: 20) {
                                
                                NavigationLink {
                                    VStack {
                                        FollowersView()
                                            .padding(.top, -85)
                                        
                                        Spacer(minLength: 0)
                                    }
                                } label: {
                                    FollowView(count: self.searchViewModel.followerUsers().count, title: "Followers")
                                }.navigationBarTitle("")

                                NavigationLink {
                                    VStack {
                                        FollowingsView()
                                            .padding(.top, -85)
                                        
                                        Spacer(minLength: 0)
                                    }
                                } label: {
                                    FollowView(count: self.searchViewModel.followingUsers().count, title: "Following")
                                }.navigationBarTitle("")

                                
                            }.padding(.top, 2)
                        }
                        .padding(.leading, 8)
                        .overlay(GeometryReader{ proxy -> Color in
                            let minY = proxy.frame(in: .global).minY
                            DispatchQueue.main.async {
                                self.titleOffset = minY
                            }
                            return Color.clear
                        }.frame(width: 0, height: 0), alignment: .top)
                        
                        Spacer()
                        
                    }
                    
                    
                    VStack(spacing: 0) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 0) {
                                TabButton(title: "Tweets", currentTab: $currentTab, animation: animation)
                                TabButton(title: "Tweets & Likes", currentTab: $currentTab, animation: animation)
                                TabButton(title: "Media", currentTab: $currentTab, animation: animation)
                                TabButton(title: "Likes", currentTab: $currentTab, animation: animation)
                            }
                        }
                        Divider()
                    }
                    .padding(.top, 30)
                    .background(Color.white)
                    .offset(y: tabBarOffset < 90 ? -tabBarOffset + 90 : 0)
                    .overlay(GeometryReader { proxy -> Color in
                        let minY = proxy.frame(in: .global).minY
                        
                        DispatchQueue.main.async {
                            self.tabBarOffset = minY
                        }
                        
                        return Color.clear
                    }.frame(width: 0, height: 0), alignment: .top)
                    .zIndex(1)
                    
                    if currentTab == "Tweets" {
                        withAnimation {
                            VStack(spacing: 18) {
                                
                                ScrollView(showsIndicators: false) {
                                    ForEach(viewModel.tweets) {
                                        TweetCellView(viewModel: TweetCellViewModel(tweet: $0, currentUser: user))
                                    }
                                }
                                
                            }
                            .padding(.top)
                            .zIndex(0)
                        }
                    }else if currentTab == "Tweets & Likes" {
                        
                    }else if currentTab == "Media" {
                        
                    }else { //currentTab == "Likes"
                        withAnimation {
                            VStack(spacing: 18) {
                                ScrollView(showsIndicators: false) {
                                    ForEach(viewModel.userLikedTweets) {
                                        TweetCellView(viewModel: TweetCellViewModel(tweet: $0, currentUser: user))
                                    }
                                }
                            }
                            .padding(.top)
                            .zIndex(0)
                        }
                    }
                }
                .padding(.horizontal, 10)
                .zIndex(-offset > 80 ? 0 : 1)
            }
        }
        .ignoresSafeArea(.all, edges: .top)
    }
    
    func blurViewOpacity() -> Double {
        let progress = -(offset + 80) / 150
        return Double(-offset > 80 ? progress : 0)
    }
    
    func getTitleOffset() -> CGFloat {
        let progress = 20 / titleOffset
        let offset = 60 * (progress > 0 && progress <= 1 ? progress : 1)
        return offset
    }
    
    func getOffset() -> CGFloat {
        let progress = -offset / 80 * 20
        return progress <= 20 ? progress : 20
    }
    
    func getScale() -> CGFloat {
        let progress = -offset/80
        let scale = 1.8 - (progress < 1.0 ? progress : 1)
        
        return scale < 1 ? scale : 1
    }
}

