//
//  SlideMenu.swift
//  Twitter-Clone
//
//  Created by Macbook Pro on 12/8/23.
//

import SwiftUI
import Kingfisher

struct SlideMenu: View {
    
    @ObservedObject var viewModel: AuthViewModel
    
    @StateObject var searchViewModel = SearchViewModel()
    
    let user: User
    
    @State var show = true
    
    var menuButtons = ["Profile", "Lists", "Topics", "Bookmarks", "Moments"]
    
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    var width = UIScreen.main.bounds.width
    
    @State var IsCreateNewAccauntPresented: Bool = false
    @State var  isAddAnExistingAccountPresented: Bool = false
    
    @Binding var x1: CGFloat
    
    var body: some View {
//        VStack {
            HStack(spacing: 0) {
                VStack(alignment: .leading) {
                    
                    HStack {
                        NavigationLink {
                            UserProfile(user: viewModel.currentUser!)
                                .onAppear {
                                    withAnimation {
                                        self.x1 = -UIScreen.main.bounds.width + 90
                                    }
                                }
                        } label: {
                            KFImage(URL(string: "\(Constants.baseURL)/users/\(self.viewModel.currentUser!.id)/avatar"))
                                .placeholder {
                                    Image("Profile")
                                        .resizable()
                                }
                                .resizable()
                                .frame(width: 60,height: 60)
                                .clipShape(Circle())
                                
                        }
                        
                        Spacer()
                        
                        Button {
                            withAnimation {
                                AuthViewModel.shared.logout()
                            }
                        } label: {
                            Text("Log Out")
                                .foregroundColor(.red)
                                .padding(.trailing, 4)
                        }

                        
                    }

                    
                    HStack(alignment: .top, spacing: 12) {
                        VStack(alignment: .leading, spacing: 12) {
                            
                            NavigationLink {
                                UserProfile(user: viewModel.currentUser!)
                                    .onAppear {
                                        withAnimation {
                                            self.x1 = -UIScreen.main.bounds.width + 90
                                        }
                                    }
                            } label: {
                                let name = UserDefaults.standard.string(forKey: AuthViewModel.shared.currentUser!.id)!
                                Text(name)
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                            }.padding(.leading, 2)
                            
                            NavigationLink {
                                UserProfile(user: viewModel.currentUser!)
                                    .onAppear {
                                        withAnimation {
                                            self.x1 = -UIScreen.main.bounds.width + 90
                                        }
                                    }
                            } label: {
                                
                                Text("@\(viewModel.currentUser!.username)")
                                    .foregroundColor(.gray)
                            }.padding(.top, -10)

                            
                            HStack(spacing: 20) {
                                
                                NavigationLink {
                                    FollowersView(user: user)
                                } label: {
                                    FollowView(count: self.searchViewModel.followerUsers(userId: user.id).count, title: "Followers")
                                }

                                NavigationLink {
                                    FollowingsView(user: user)
                                } label: {
                                    FollowView(count: self.searchViewModel.followingUsers(userId: user.id).count, title: "Following")
                                }

                                
                            }.padding(.top, 2)
                            
                            Divider()
                                .padding(.top, 2)
                            
                        }
                        
                        Spacer(minLength: 0)
                        
                        Button {
                            withAnimation {
                                self.show.toggle()
                            }
                        } label: {
                            Image(systemName: show ? "chevron.down" : "chevron.up")
                                    .foregroundColor(Color("bg"))
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 0) {
                        VStack(spacing: 12) {
                            ForEach(menuButtons, id:\.self) { item in
                                NavigationLink {
                                    if (item == "Profile") {
                                        UserProfile(user: viewModel.currentUser!)
                                        //                                        .onAppear {
                                        //                                            withAnimation {
                                        //                                                self.x1 = -UIScreen.main.bounds.width + 90
                                        //                                            }
                                        //                                        }
                                    }else if (item == "Lists") {
                                        
                                    }else if (item == "Topics") {
                                        
                                    }else if (item == "Bookmarks") {
                                        
                                    }else { //item == "Moments"
                                        
                                    }
                                } label: {
                                    // THE PROBLEM IS HERE:: THIS MAKES VIEW MOVE UP WHEN KEYBOARD SHOWS UP!
                                    MenuButton(title: item)
//                                        .padding(.vertical, 8)
                                        .contentShape(Rectangle()) // improves tap area without pushing layout
                                }
                                
                            }
                        }
//                        Spacer(minLength: 12)
//                        VStack(spacing: 12) {
//                            MenuButton(title: menuButtons[0])
//                                .padding(.vertical, 8)
//                                    .contentShape(Rectangle()) // improves tap area without pushing layout
//                            
//                            MenuButton(title: menuButtons[1])
//                                .padding(.vertical, 8)
//                                    .contentShape(Rectangle()) // improves tap area without pushing layout
//                            
//                            MenuButton(title: menuButtons[2])
//                                .padding(.vertical, 8)
//                                    .contentShape(Rectangle()) // improves tap area without pushing layout
//                            
//                            MenuButton(title: menuButtons[3])
//                                .padding(.vertical, 8)
//                                    .contentShape(Rectangle()) // improves tap area without pushing layout
//                            
//                            MenuButton(title: menuButtons[4])
//                                .padding(.vertical, 8)
//                                    .contentShape(Rectangle()) // improves tap area without pushing layout
//                        }
                        
                        Divider()
//                            .padding(.top)
                        
                        Button {
                            
                        } label: {
                            MenuButton(title: "Twitter Ads")
                                .padding(.vertical, 8)
                                    .contentShape(Rectangle()) // improves tap area without pushing layout
                        }
                        
                        Divider()
                        
                        Button {
                            
                        } label: {
                            Text("Setings and Privacy")
                                .foregroundColor(.black)
                            
                        }.padding(.top, 20)
                        
                        Button {
                            
                        } label: {
                            Text("Help Centre")
                                .foregroundColor(.black)
                        }

                        
                        Spacer(minLength: 0)
                        
                        Divider()
                            .padding(.bottom)
                        
                        HStack {
                            Button {
                                
                            } label: {
                                Image("help")
                                    .renderingMode(.template)
                                    .scaledToFit()
                                    .frame(width: 26, height: 26)
                                    .foregroundColor(Color("bg"))
                            }
                            Spacer(minLength: 0)
                            
                            Button {
                                
                            } label: {
                                Image("Barcode")
                                    .resizable()
                                    .renderingMode(.template)
                                    .frame(width: 27, height: 27)
                                    .foregroundColor(Color("bg"))
                            }


                        }
                    }
                    .opacity(show ? 1 : 0)
                    .frame(height: show ? nil : 0)
//                    .frame(maxHeight: .infinity, alignment: .top) // keep fixed top anchor
                    .ignoresSafeArea(.keyboard, edges: .bottom)
                    
                    VStack(alignment: .leading) {
                        Spacer(minLength: 30);
                        
                        Button {
                            self.IsCreateNewAccauntPresented.toggle()
                        } label: {
                            Text("Create a New Account")
                                .foregroundColor(Color("bg"))
                        }
                        .sheet(isPresented: $IsCreateNewAccauntPresented) {
                            RegisterView()
                                .onAppear {
                                    withAnimation {
                                        self.x1 = -width + 90
                                    }
                                }
                                .padding(.top, 15)
                        }
                        
                        Button {
                            self.isAddAnExistingAccountPresented.toggle()
                        } label: {
                            Text("Add an Existing Account")
                                .foregroundColor(Color("bg"))
                        }
                        .padding(.top, 1)
                        .sheet(isPresented: $isAddAnExistingAccountPresented) {
                            LogInView()
                                .onAppear {
                                    withAnimation {
                                        self.x1 = -width + 90
                                    }
                                }
                                .padding(.top, 15)
                        }
                        
//                        Spacer(minLength: 0)
                        

                    }
                    .opacity(show ? 0 : 1)
                    .frame(height: show ? 0 : nil)
                }
                .padding(.horizontal, 12)
                .padding(.top, edges?.top == 0 ? 15 : edges?.top)
                .padding(.bottom, edges?.bottom == 0 ? 15 : edges?.bottom)
                .frame(width: width - 90)
                .background(Color.white)
                .ignoresSafeArea(.all)
                
                Spacer(minLength: 0)
                
            }
//        }
//        .ignoresSafeArea(.keyboard)
    }
}

