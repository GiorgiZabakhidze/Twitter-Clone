//
//  SlideMenu.swift
//  Twitter-Clone
//
//  Created by Macbook Pro on 12/8/23.
//

import SwiftUI

struct SlideMenu: View {
    @State var show = false
    
    var menuButtons = ["Profile", "Lists", "Topics", "Bookmarks", "Moments"]
    
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    var width = UIScreen.main.bounds.width
    
    var body: some View {
        VStack {
            HStack(spacing: 0){
                VStack(alignment: .leading) {
                    Image("profile_pic")
                        .resizable()
                        .frame(width: 60,height: 60)
                        .clipShape(Circle())
                    HStack(alignment: .top, spacing: 12) {
                        VStack(alignment: .leading, spacing: 12) {
                             Text("zabaxa")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                            Text("@Giorgi_Zabakhidze")
                                .foregroundColor(.gray)
                            
                            HStack(spacing: 20) {
                                FollowView(count: 999, title: "Followers")
                                FollowView(count: 16, title: "Following")
                            }.padding(.top, 10)
                            Divider()
                                .padding(.top, 10)
                            
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
                    
                    VStack(alignment: .leading) {
                        ForEach(menuButtons, id:\.self) { item in
                            Button {
                                
                            } label: {
                                MenuButton(title: item)
                            }
                        }
                        
                        Divider()
                            .padding(.top)
                        
                        Button {
                            
                        } label: {
                            MenuButton(title: "Twitter Ads")
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
                    
                    VStack(alignment: .leading) {
                        Button {
                            
                        } label: {
                            Text("Create a New Account")
                                .foregroundColor(Color("bg"))
                        }
                        
                        Button {
                            
                        } label: {
                            Text("Add an Existing Account")
                                .foregroundColor(Color("bg"))
                        }
                        
                        Spacer(minLength: 0)

                    }
                    .opacity(show ? 0 : 1)
                    .frame(height: show ? 0 : nil)
                }
                .padding(.horizontal, 12)
                .padding(.top, edges?.top == 0 ? 15 : edges?.top)
                .padding(.bottom, edges?.bottom == 0 ? 15 : edges?.bottom)
                .frame(width: width - 90)
                .background(Color.white)
                .ignoresSafeArea(.all, edges: .vertical)
                .ignoresSafeArea(.all, edges: .horizontal)
                
                Spacer(minLength: 0)
                
            }
        }
    }
}

struct SlideMenu_Previews: PreviewProvider {
    static var previews: some View {
        SlideMenu()
    }
}
